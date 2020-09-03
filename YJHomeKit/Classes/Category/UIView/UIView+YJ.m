//
//  UIView+tool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "UIView+YJ.h"

@implementation UIView (YJ)

- (void)yj_updateConstraints
{
    [self updateConstraintsIfNeeded];//强制更新约束
    [self layoutIfNeeded];//强制刷新界面
}

- (BOOL)isShowingOnKeyWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

/** 是否相交 */
- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)doBorderWidth:(CGFloat)width color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (void)showAlert:(NSString *)title message:(NSString *)message
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (void)showAlert:(NSString *)message
{
    [self showAlert:@"" message:message];
}

- (void)setLabelShadow
{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        label.shadowColor = [UIColor colorWithWhite:0 alpha:0.6];
        label.shadowOffset = CGSizeMake(1, 1);
    }
}

+ (instancetype)autolayoutView
{
    UIView *view = [[self alloc] initWithFrame:CGRectZero];
    //如果你定义的view想用autolayout，就将translatesAutoresizingMaskIntoConstraints设为NO
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+(instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)top{
    return self.frame.origin.y;
}
- (void) setTop: (CGFloat) newtop{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left{
    return self.frame.origin.x;
}
- (void) setLeft: (CGFloat) newleft{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom{
    return self.frame.origin.y + self.frame.size.height;
}
- (void) setBottom: (CGFloat) newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void) setRight: (CGFloat) newright{
    CGRect newframe = self.frame;
    newframe.origin.x = newright - self.frame.size.width;
    self.frame = newframe;
}

@end
