//
//  YJTabBarItem.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import <UIKit/UIKit.h>

@class YJTabBarItem;

@protocol YJTabBarItemDelegate <NSObject>
- (void)tabBarItemDidSelectItem:(YJTabBarItem *)item;
@end

@interface YJTabBarItem : UIView
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  默认图片
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  选中时候的图片
 */
@property (nonatomic, strong) UIImage *selectedImage;
/**
 *  图片的偏移
 */
@property (nonatomic) UIEdgeInsets imageInsets;
/**
 *  提示字符
 */
@property (nonatomic, copy) NSString *badgeValue;
/**
 *  显示红点指示
 */
@property (nonatomic) BOOL showIndicate;
/**
 *  是否选中
 */
@property (nonatomic, getter = isSelected) BOOL selected;
/**
 *  是否显示标题
 */
@property (nonatomic, getter = isShowWord) BOOL showWord;
/**
 *  代理
 */
@property (nonatomic, weak) id<YJTabBarItemDelegate> delegate;
/**
 *  创建函数
 *
 *  @param title         标题
 *  @param image         默认图片
 *  @param selectedImage 选中时候的图片
 */
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

@end
