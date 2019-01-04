//
//  UIView+YJRoute.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "UIView+YJRoute.h"

@implementation UIView (YJRoute)

- (UIViewController *)yj_currentController
{
    UIViewController *result = nil;
    UIWindow *window = [self isKindOfClass:[UIWindow class]] ? (UIWindow *)self : self.window;
    result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    
    NSLog(@"currentController = %@",NSStringFromClass([result class]));
    return result;
}

@end
