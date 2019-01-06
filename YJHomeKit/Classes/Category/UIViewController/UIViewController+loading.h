//
//  UIViewController+loading.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import <UIKit/UIKit.h>

@interface UIViewController (loading)

/**
 *  功能:显示loading
 */
- (void)showLoading;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second;

/**
 *  功能:显示loading
 */
- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second;

/**
 *  功能:隐藏loading
 */
- (void)hideLoading;

/**
 *  功能:隐藏loading
 */
- (void)hideLoadingOnView:(UIView *)aView;

/**
 *  功能:显示非模态loading
 */
- (void)showNonModelLoading;

/**
 *  功能:隐藏非模态loading
 */
- (void)hideNonModelLoading;

@end


