//
//  UIView+tool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import <UIKit/UIKit.h>

@interface UIView (YJ)

+ (instancetype)autolayoutView;

+ (instancetype)viewFromXib;

/** 是否相交 */
- (BOOL)intersectWithView:(UIView *)view;

- (BOOL)isShowingOnKeyWindow;

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

@end
