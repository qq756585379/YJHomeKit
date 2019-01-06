//
//  YJRouter.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "YJRouter.h"
#import "UIViewController+YJRoute.h"

@interface YJRouter ()
@property (nonatomic, strong) NSArray *tabArray;
@property (nonatomic, strong) NSString *appScheme;
@property (nonatomic, strong) NSString *appFuncScheme;
@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) NSMutableDictionary *mapping;
@property (nonatomic, strong) UIViewController *pcContainer;
@property (copy,   nonatomic) void(^routeActionBlock)(NSString *actionName, NSDictionary *data);
@end

@implementation YJRouter

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id __singleton__ = nil;
    dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
        NSLog(@"bundleIdentifier == %@",bundleIdentifier);
        self.mapping = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (void)startWithUrlScheme:(NSString *)scheme
                  pageHost:(NSString *)pageMark
                actionHost:(NSString *)actionMark
               actionBlock:(void (^)(NSString *actionName, NSDictionary *data))block
{
    [[YJRouter sharedInstance] setAppScheme:scheme];
    //    [[YJRouter sharedInstance] set]
    //    [[YJRouter sharedInstance] setRouteBlock:block];
}

#pragma mark - Register
- (void)registerRootVC:(UIViewController *)aRootVC
{
    if (self.rootVC) {
        NSLog(@"已经设置了rootvc，不能重复设置");
        return ;
    }
    self.rootVC = aRootVC;
}

- (void)registerTabArray:(NSArray *)aTabArray
{
    if (self.tabArray) {
        NSLog(@"已经设置了tabarray，不能重复设置");
        return ;
    }
    self.tabArray = aTabArray;
}

- (void)registerPCContainer:(UIViewController *)aPCContainer
{
    if (self.pcContainer) {
        NSLog(@"已经设置了pc Container，不能重复设置");
        return ;
    }
    self.pcContainer = aPCContainer;
}

- (void)registerRouterVO:(YJMappingVO *)aVO withKey:(NSString *)aKeyName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && aVO.loadFilterType == YJMappingClassPlatformTypePad) {
        return;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && aVO.loadFilterType == YJMappingClassPlatformTypePhone) {
        return;
    }
    if (self.mapping[aKeyName]) {
        NSLog(@"overwrite router vo key[%@], mapping vo,%@", aKeyName, self.mapping[aKeyName]);
    }
    self.mapping[aKeyName] = aVO;
}

#pragma mark - Router
+ (id)routeToDestVc:(NSString *)destVc from:(UIViewController *)fromVc extraData:(NSDictionary *)extraData
{
    YJRouter *router = [YJRouter sharedInstance];
    YJMappingVO *mappingVO = [router.mapping objectForKey:destVc];
    if (mappingVO == nil) {
        return nil;
    }
    
    UIViewController *vc = [UIViewController createWithMappingVO:mappingVO extraData:extraData];
    if (!vc) {
        NSLog(@"router error, can not new one");
        return nil;
    }
    
    if (mappingVO.routeType == YJRouteTypePush) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            NSLog(@"cannot push a nc");
            return nil;
        }
        vc.hidesBottomBarWhenPushed = YES;
        [fromVc.navigationController pushViewController:vc animated:YES];
    } else if (mappingVO.routeType == YJRouteTypePresent){
        [fromVc presentViewController:vc animated:YES completion:^{
            
        }];
    }
    
    return vc;
}

@end
