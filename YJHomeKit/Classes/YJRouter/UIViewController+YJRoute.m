//
//  UIViewController+YJRoute.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "UIViewController+YJRoute.h"
#import "YJMappingVO.h"
#import "YJRouter.h"

@implementation UIViewController (YJRoute)

+ (instancetype)createWithMappingVO:(YJMappingVO *)aMappingVO extraData:(NSDictionary *)aParam
{
    if (aMappingVO.className == nil) {
        NSLog(@"error %@, className is nil",aMappingVO.description);
        return nil;
    }
    
    Class class = NSClassFromString(aMappingVO.className);
    if (!class) {
        NSLog(@"error %@, no such class",aMappingVO);
        return nil;
    }
    
    UIViewController *vc = nil;
    if (aMappingVO.createdType == YJMappingClassCreateByCode) {
        vc = [[class alloc] initWithNibName:nil bundle:nil];
    }
    else if (aMappingVO.createdType == YJMappingClassCreateByXib) {
        NSBundle *bundle = [self getBundleWithBundleName:aMappingVO.bundleName];
        vc = [[class alloc] initWithNibName:aMappingVO.nibName bundle:bundle];
    }
    else if (aMappingVO.createdType == YJMappingClassCreateByStoryboard) {
        NSBundle *bundle = [self getBundleWithBundleName:aMappingVO.bundleName];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aMappingVO.storyboardName bundle:bundle];
        vc = [storyboard instantiateViewControllerWithIdentifier:aMappingVO.storyboardID];
    }
    
    // kvc设置参数
    if (aParam && vc) {
        [aParam enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            @try {
                [vc setValue:obj forKey:key];
            } @catch (NSException *exception) {
                NSLog(@"%@",exception);
            } @finally {}
        }];
    }
    
    return vc;
}

+ (NSBundle *)getBundleWithBundleName:(NSString *)aBundleName
{
    if (aBundleName.length) {
        return [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    
    return [NSBundle mainBundle];
}

// 获取view当前所在controller
- (UIViewController *)yj_currentController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *w in windows) {
            if (w.windowLevel == UIWindowLevelNormal) {
                window = w;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

//- (id)yj_routerByData:(YJRouterData *)routeData extraData:(NSDictionary *)extraData
//{
//    return [[YJRouter sharedInstance] routerByData:routeData from:self extraData:extraData];
//}

@end
