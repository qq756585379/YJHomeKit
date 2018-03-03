//
//  YJTabBar.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import <UIKit/UIKit.h>

@class YJTabBarItem,YJTabBar;

@protocol YJTabBarDelegate <NSObject>
- (void)customTabBar:(YJTabBar *)tabBar didSelectItem:(YJTabBarItem *)item;
@end

@interface YJTabBar : UIView

/**
 *  背景图片
 */
@property (nonatomic, strong) UIImage *backgroundImage;
/**
 *  代理
 */
@property (nonatomic,   weak) id<YJTabBarDelegate> delegate;
/**
 *  当前选中的tabbarItem的序号
 */
@property (nonatomic, readonly) NSUInteger selectedIndex;

@end
