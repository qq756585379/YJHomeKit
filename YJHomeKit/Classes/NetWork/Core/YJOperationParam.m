//
//  YJOperationParam.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "YJOperationParam.h"
#import "YJConnectUrl.h"

@implementation YJOperationParam

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithBusinessName:(NSString *)aBusinessName
                           methodName:(NSString *)aMethodName
                           versionNum:(NSString *)aVersionNum
                                 type:(ERequestType)aType
                                param:(NSDictionary *)aParam
                             callback:(YJCompletionBlock)aCallback{
    YJOperationParam *param = [self new];
    param.businessName = aBusinessName;
    param.methodName = aMethodName;
    param.versionNum = aVersionNum;
    NSString *domain = param.currentDomain;
    if (aVersionNum.length > 0) {
        param.requestUrl = [NSString stringWithFormat:@"%@/%@/%@/%@", domain, aBusinessName, aMethodName, aVersionNum];
    } else {
        param.requestUrl = [NSString stringWithFormat:@"%@/%@/%@", domain, aBusinessName, aMethodName];
    }
    param.requestType = aType;
    param.requestParam = aParam ? aParam : [NSMutableDictionary dictionary];
    param.callbackBlock = aCallback;
    
    return param;
}

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                        type:(ERequestType)aType
                       param:(NSDictionary *)aParam
                    callback:(YJCompletionBlock)aCallback{
    YJOperationParam *param = [self new];
    param.requestUrl = aUrl;
    param.requestType = aType;
    param.requestParam = aParam ? aParam : [NSMutableDictionary dictionary];
    param.callbackBlock = aCallback;
    
    //for print log
    param.methodName = aUrl;
    return param;
}

/**
 *  功能:当前域名
 */
- (NSString *)currentDomain
{
    return [YJConnectUrl sharedInstance].domain;
}

@end
