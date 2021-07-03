//
//  YJHTTPSessionManager.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "YJOperationManager.h"
#import "YJNetworkError.h"
#import "NSObject+PerformBlock.h"
#import "NSMutableArray+safe.h"
#import "YJGlobalValue.h"
#import "NSString+tool.h"

@interface YJOperationManager()
@property(nonatomic, assign) BOOL sessionIsInvalid;//session是否无效
@property(nonatomic, strong) NSString *hostClassName;//宿主名称
//这里记录operation param，防止其释放，token过期处理会用到operation param
@property(nonatomic, strong) NSMutableArray *operationParams;
@end

@implementation YJOperationManager

+ (instancetype)managerWithOwner:(id)owner{
    YJOperationManager *operationManager = [super manager];
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    operationManager.responseSerializer = [AFJSONResponseSerializer serializer];//设置json解析
    operationManager.requestSerializer.timeoutInterval = 5;

    NSSet *set = [NSSet setWithObjects:@"text/html", @"application/json", @"application/javascript", @"text/plain",
                  @"text/json", @"application/x-javascript", nil];
    operationManager.responseSerializer.acceptableContentTypes = set;
    operationManager.hostClassName = NSStringFromClass([owner class]);
    //缓存策略
//    operationManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    //session无效
    __weak YJOperationManager *weakManager = operationManager;
    [operationManager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        __strong YJOperationManager *strongManager = weakManager;
        strongManager.sessionIsInvalid = YES;
    }];
    
    return operationManager;
}

/**
 *  功能:发送请求
 */
- (NSURLSessionDataTask *)requestWithParam:(YJOperationParam *)aParam{
    if (aParam == nil) return nil;
    
    if (self.sessionIsInvalid) {//session无效
        NSLog(@"{method name}: %@\n\nerror:\nsession invalid\n", aParam.methodName);
        [self performInMainThreadBlock:^{
            NSError *error = [NSError errorWithDomain:@"session invalid" code:kSessionInvalid userInfo:nil];
            if (aParam.isNeedRacRequest) {
                [aParam.subscriber sendError:error];
            } else if (aParam.callbackBlock) {
                aParam.callbackBlock(nil, error);
            }
            [self.operationParams removeObject:aParam];
        }];
        return nil;
    }
    
    //将operation param加入数组，便于管理
    [self.operationParams safeAddObject:aParam];
    //requestSerializer处理
    [self modifyRequestSerializerWithParam:aParam];
    
    //业务参数组装
    NSMutableDictionary *params = aParam.requestParam.mutableCopy;
    NSString *requestUrl = aParam.requestUrl;
    NSURLSessionDataTask *requestOperation = nil;
    
    WEAK_SELF
    if (aParam.requestType == kRequestPost) {//POST方式
        
      requestOperation = [self POST:requestUrl parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF
            [self successWithTask:task responseObject:responseObject param:aParam];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF
            [self failWithTask:task error:error param:aParam];
        }];
    }else{
        requestOperation = [self GET:requestUrl parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            STRONG_SELF
            [self successWithTask:task responseObject:responseObject param:aParam];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            STRONG_SELF
            [self failWithTask:task error:error param:aParam];
        }];
    }
    
    //记录接口开始调用时间，便于统计接口耗时
    aParam.startTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    //打印Request
    [self printRequest:aParam operation:requestOperation];
    return requestOperation;
}

#pragma mark - Success & Fail
/**
 *  功能:接口调用成功处理
 */
- (void)successWithTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject param:(YJOperationParam *)aParam{
    if ([responseObject isKindOfClass:[NSArray class]]) {
        NSMutableDictionary *responseDict = @{}.mutableCopy;
        responseDict[@"rtn_code"] = @"0";
        responseDict[@"data"] = responseObject;
        responseObject = responseDict;
    }
    
    //打印成功的Response
    [self printSuccessResponse:aParam responseObject:responseObject];
    //统计日志上传
    [self uploadLog:aParam responseObject:responseObject];
    
    id data = [responseObject objectForKey:@"data"];
    NSNumber *code = [responseObject objectForKey:@"code"];
    NSString *message = [responseObject objectForKey:@"message"];
  
    NSError *error = nil;
    if (code.intValue != 0) {
        NSString *msg = message ? message : @"请求失败！";
        NSMutableDictionary *userInfo = [responseObject mutableCopy];
        userInfo[NSLocalizedDescriptionKey] = msg;
        error = [NSError errorWithDomain:@"InterfaceReturnError" code:kReturnCodeNotEqualToZero userInfo:[userInfo copy]];
    }
    
    if (error) {
        if (aParam.isNeedRacRequest) {
            if (!aParam.blockSendError) {
                [aParam.subscriber sendError:error];
            }
        } else if (aParam.callbackBlock) {
            aParam.callbackBlock(nil, error);
        }
    } else {
        if (aParam.isNeedRacRequest) {
            [aParam.subscriber sendNext:data];
            [aParam.subscriber sendCompleted];
        } else if (aParam.callbackBlock) {
            aParam.callbackBlock(data, nil);
        }
    }
    
    [self.operationParams removeObject:aParam];
}

/**
 *  功能:接口调用失败处理
 */
- (void)failWithTask:(NSURLSessionDataTask *)task error:(NSError *)aError param:(YJOperationParam *)aParam{
    //打印失败的日志
    [self printFailResponse:aParam error:aError];
    
    if (aParam.isNeedRacRequest) {
        if (!aParam.blockSendError) {
            [aParam.subscriber sendError:aError];
        }
    } else if (aParam.callbackBlock) {
        aParam.callbackBlock(nil, aError);
    }
    
    if (aParam.retryTimes <= 0) {
        [self.operationParams removeObject:aParam];
    } else {//接口重试
        aParam.retryTimes --;
        [self requestWithParam:aParam];
    }
}

/**
 *  功能:取消当前manager queue中所有网络请求
 */
- (void)cancelAllOperations{
    
}

#pragma mark - 接口日志上传
/**
 *  接口日志上传
 */
- (void)uploadLog:(YJOperationParam *)aParam responseObject:(id)aResponseObject{
    
}

#pragma mark -- Inner
/**
 *  功能:修改RequestSerializer
 */
- (void)modifyRequestSerializerWithParam:(YJOperationParam *)aParam{
    //超时时间
    if (aParam.timeoutTime) {
        self.requestSerializer.timeoutInterval = aParam.timeoutTime;
    }
    //Cache-control(缓存时间)
    [self.requestSerializer setValue:[NSString stringWithFormat:@"max-age=%.0f", aParam.cacheTime] forHTTPHeaderField:@"Cache-control"];
    //User-Agent
    NSString *userAgent = [NSString stringWithFormat:@"%@-%@-%@-(%@; iOS %@)", (IS_IPAD_DEVICE ? @"ipad": @"iphone"), ([[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ? : [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey]), ([[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ? : [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey]), [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
    [self.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    //Content-Type
    if (aParam.requestType == kRequestPost) {
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    } else {
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Content-Type"];
    }
    
    [self.requestSerializer setValue:@"{\"userToken\":\"d04e89dd-2565-4249-b7ea-f0d619cc8d5f\"}" forHTTPHeaderField:@"header"];
}

#pragma mark - 打印Request & Response
/**
 *  打印Request，主要是接口请求的参数描述
 */
- (void)printRequest:(YJOperationParam *)aParam operation:(NSURLSessionDataTask *)requestOperation{
#ifdef DEBUG
    NSURLRequest *request = [requestOperation currentRequest];
    NSString *unEncodeUrl = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSTimeInterval dTime = [YJGlobalValue sharedInstance].dTime;//服务器时间-本地时间
    NSTimeInterval serverTimeStamp = [[NSDate date] timeIntervalSince1970] + dTime;
    NSDate *localDate = [NSDate date];
    NSDate *serverDate = [NSDate dateWithTimeIntervalSince1970:serverTimeStamp];
    NSLog(@"{method name}: %@\n\n{method params}:  %@\n\n{url before encode}:\n%@\n\n{signature key before encode}:\n%@\n\n{token before encode}:\n%@\n\n{local time}:%@\n\n{d time}:%f\n\n{server time}:%@\n\n{used ip}:%@\n\n{global ip}:%@\n", aParam.methodName, aParam.requestParam, unEncodeUrl, [YJGlobalValue sharedInstance].signatureKey, [YJGlobalValue sharedInstance].token, localDate, dTime, serverDate, aParam.usedIp, @"serverIp");
#endif
}

/**
 *  打印成功的Response
 */
- (void)printSuccessResponse:(YJOperationParam *)aParam responseObject:(id)aResponseObject{
#ifdef DEBUG
    NSLog(@"(%lld)接口返回成功\n\n接口名%@\n接口内容%@\n\n", (long long)([[YJGlobalValue sharedInstance].serverTime timeIntervalSince1970]*1000),
          aParam.requestUrl, aResponseObject);
    
    NSString *description = [aResponseObject description];
    if (description) {
        description = [NSString unicodeToUtf8:description];
    }
    if (description && description.length > 0) {
        NSLog(@"{method name}: %@\n\n{response}:\n%@\n", aParam.methodName, description);
    } else {
        NSLog(@"{method name}: %@\n\n{response}:\n%@\n", aParam.methodName, aResponseObject);
    }
#endif
}

/**
 *  打印失败的Response
 */
- (void)printFailResponse:(YJOperationParam *)aParam error:(NSError *)aError{
#ifdef DEBUG
    NSString *errorMessage = [aError description];
    if (errorMessage) {
        errorMessage = [NSString unicodeToUtf8:errorMessage];
    }
    if (errorMessage && errorMessage.length > 0) {
        NSLog(@"{method name}: %@\n\nerror:\n%@\n", aParam.methodName,errorMessage);
    } else {
        NSLog(@"{method name}: %@\n\nerror:\n%@\n", aParam.methodName, aError);
    }
#endif
}

- (void)dealloc{
    NSLog(@"[%@ call %@ --> %@]", [self class], NSStringFromSelector(_cmd), _hostClassName);
}

#pragma mark - Property
- (NSMutableArray *)operationParams{
    if (_operationParams == nil) {
        _operationParams = @[].mutableCopy;
    }
    return _operationParams;
}

@end
