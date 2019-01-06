//
//  UIViewController+net.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import <UIKit/UIKit.h>
#import "YJOperationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (net)

/**
 *  网络管理
 */
@property (nonatomic, strong) YJOperationManager *operationManager;

- (void)cancelAllOperations;

@end

NS_ASSUME_NONNULL_END
