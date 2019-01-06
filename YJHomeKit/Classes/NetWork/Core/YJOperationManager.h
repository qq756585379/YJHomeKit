//
//  YJHTTPSessionManager.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "AFHTTPSessionManager.h"
#import "YJOperationParam.h"

typedef NS_ENUM(NSInteger, ForceTip)
{
    kShowAWhile = 0,             //显示一会提示
    kForceShow,                  //强制显示
    kForceJump,                  //强行跳转
    KForceUpdate                 //强制更新模块
};

@interface YJOperationManager : AFHTTPSessionManager

@property (nonatomic, assign) NSTimeInterval dTime;//服务器时间-客户端时间

/**
 *  初始化函数,宿主owner
 */
+ (instancetype)managerWithOwner:(id)owner;

/**
 *  功能:发送请求
 */
- (NSURLSessionDataTask *)requestWithParam:(YJOperationParam *)aParam;

/**
 *  功能:取消当前manager queue中所有网络请求
 */
- (void)cancelAllOperations;

@end

