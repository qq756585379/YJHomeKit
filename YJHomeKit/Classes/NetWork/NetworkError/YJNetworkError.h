//
//  YJNetworkError.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import <Foundation/Foundation.h>
#import "YJOperationManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    kLaunchFail = 1,                    //启动接口调用失败
    kLoginFailWhenTokenExpire,          //token过期后自动登录失败
    kGetSignKeyFailWhenSignKeyExpire,   //密钥过期后重新获取密钥失败
    kReturnCodeNotEqualToZero,          //rtn_code不为0
    kDataTypeMismatch,                  // 数据类型不匹配
    kChangeIpForServerError,            //服务器5xx错误后更换ip后仍然失败
    kSessionInvalid,                    //session无效
    kNotConnectToServer = -1004,        //网络连接错误
    kServerError = -1011,               //服务器错误
} ENetworkError;

typedef void(^YJErrorHandleCompleteBlock)(BOOL success);
typedef void(^YJErrorHandleBlock)(YJErrorHandleCompleteBlock errorHandleCompleteBlock);

@interface YJNetworkError : NSObject

@property(nonatomic,   copy) YJErrorHandleBlock errorHandleBlock;//错误处理block
@property(nonatomic, assign) BOOL handling;//是否正在错误处理

/**
 *  功能:错误处理
 *  返回:是否需要继续执行call back
 */
- (BOOL)dealWithManager:(YJOperationManager *)aManager
                  param:(YJOperationParam *)aParam
              operation:(NSURLSessionDataTask *)aOperation
         responseObject:(id)aResponseObject
                  error:(NSError *)aError;

@end

NS_ASSUME_NONNULL_END
