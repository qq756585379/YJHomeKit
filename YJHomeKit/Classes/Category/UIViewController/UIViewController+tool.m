//
//  UIViewController+tool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/2.
//

#import "UIViewController+tool.h"
#import <objc/runtime.h>

@implementation UIViewController (tool)

+ (void)load
{
    Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod(self, @selector(yj_dealloc));
    method_exchangeImplementations(method1, method2);
}

- (void)yj_dealloc{
    NSLog(@"%@ - yj_dealloc", self);
    [self yj_dealloc];
}

@end
