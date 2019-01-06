//
//  YJNetworkManager.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "YJNetworkFactory.h"

@implementation YJNetworkFactory

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id __singleton__ = nil;
    dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

/**
 *  功能:产生一个operation manager
 */
- (YJOperationManager *)generateOperationMangerWithOwner:(id)owner{
    YJOperationManager *operationManager = [YJOperationManager managerWithOwner:owner];
    [self.operationManagers addObject:operationManager];
    return operationManager;
}

/**
 *  功能:移除operation manager
 */
- (void)removeOperationManger:(YJOperationManager *)aOperationManager{
    [self.operationManagers removeObject:aOperationManager];
}

- (NSMutableArray *)operationManagers{
    if (_operationManagers == nil) {
        _operationManagers = [NSMutableArray array];
    }
    return _operationManagers;
}

@end
