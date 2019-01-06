//
//  BaseTabBarController.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import <UIKit/UIKit.h>

@interface YJTabBarController : UITabBarController <UITabBarControllerDelegate>

/**
 *  更新某个index的tab
 */
- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex;

@end
