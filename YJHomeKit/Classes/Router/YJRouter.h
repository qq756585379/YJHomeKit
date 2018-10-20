//
//  YJRouter.h
//  Pods
//
//  Created by 杨俊 on 2018/5/28.
//

#import <Foundation/Foundation.h>
#import "UIViewController+router.h"
#import "YJMappingVO.h"

@interface YJRouter : NSObject

@property (nonatomic, strong, readonly) NSArray *tabArray;
@property (nonatomic, strong, readonly) NSString *appScheme;
@property (nonatomic, strong, readonly) UIViewController *rootVC;
@property (nonatomic, strong, readonly) NSMutableDictionary *mapping;
@property (nonatomic, strong, readonly) UIViewController *pcContainer;

+ (instancetype)sharedInstance;

#pragma mark - Register
- (void)registerTabArray:(NSArray *)aTabArray;
- (void)registerRootVC:(UIViewController *)aRootVC;
- (void)registerPCContainer:(UIViewController *)aPCContainer;
- (void)registerRouterVO:(YJMappingVO *)aVO withKey:(NSString *)aKeyName;

@end
