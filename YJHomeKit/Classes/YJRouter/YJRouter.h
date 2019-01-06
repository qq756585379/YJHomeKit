//
//  YJRouter.h
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "YJMappingVO.h"

@interface YJRouter : NSObject

@property (nonatomic, strong, readonly) NSArray *tabArray;
@property (nonatomic, strong, readonly) NSString *appScheme;
@property (nonatomic, strong, readonly) NSString *appFuncScheme;
@property (nonatomic, strong, readonly) UIViewController *rootVC;
@property (nonatomic, strong, readonly) NSMutableDictionary *mapping;
@property (nonatomic, strong, readonly) UIViewController *pcContainer;
@property (copy,   nonatomic) void(^routeBlock)(NSString *actionName,NSDictionary *data);

+ (instancetype)sharedInstance;

+ (void)startWithUrlScheme:(NSString *)scheme
                  pageHost:(NSString *)pageMark
                actionHost:(NSString *)actionMark
               actionBlock:(void (^)(NSString *actionName, NSDictionary *data))block;

#pragma mark - Register
- (void)registerTabArray:(NSArray *)aTabArray;
- (void)registerRootVC:(UIViewController *)aRootVC;
- (void)registerPCContainer:(UIViewController *)aPCContainer;
- (void)registerRouterVO:(YJMappingVO *)aVO withKey:(NSString *)aKeyName;

#pragma mark - Router
+ (id)routeToDestVc:(NSString *)destVc from:(UIViewController *)fromVc extraData:(NSDictionary *)extraData;

@end

