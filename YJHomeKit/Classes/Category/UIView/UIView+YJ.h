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

- (BOOL)isShowingOnKeyWindow;

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

- (void)setLabelShadow;
- (void)showAlert:(NSString *)message;
- (void)showAlert:(NSString *)title message:(NSString *)message;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@end
