//
//  UIViewController+net.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "UIViewController+net.h"
#import "NSObject+category.h"
#import "YJNetworkFactory.h"

@implementation UIViewController (net)

- (void)setOperationManager:(YJOperationManager *)operationManager
{
    if (operationManager != self.operationManager) {
        [self objc_setAssociatedObject:@"operationManager" value:operationManager policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    }
}

- (YJOperationManager *)operationManager
{
    YJOperationManager *manager = [self objc_getAssociatedObject:@"operationManager"];
    if (manager == nil) {
        manager = [[YJNetworkFactory sharedInstance] generateOperationMangerWithOwner:self];
        [self objc_setAssociatedObject:@"operationManager" value:manager policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    }
    return manager;
}

- (void)cancelAllOperations{
    [self.operationManager cancelAllOperations];
}

@end
