//
//  XiuXiuViewController.m
//  Example
//
//  Created by 杨俊 on 2018/5/15.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "XiuXiuViewController.h"

@interface XiuXiuViewController ()
{
    UIView *_circleView;
    UIButton *_button;
}
@end

@implementation XiuXiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 设置背景颜色 35    39    63
    self.view.backgroundColor = [UIColor colorWithRed:35 / 255.0 green:39 / 255.0 blue:63 / 255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    // 2. 添加按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 60, 60)];
    [button setImage:[UIImage imageNamed:@"alipay_msp_op_success"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    _button = button;
    // 3. 添加圆形视图
    _circleView = [self circleView];
    [self.view insertSubview:_circleView belowSubview:button];
    // 4. 添加监听方法
    [button addTarget:self action:@selector(startXiuxiu:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRippleLayer
{
    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.frame = self.view.frame;
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    rippleLayer.strokeColor = [UIColor greenColor].CGColor;
    rippleLayer.lineWidth = 1.5;
    [self.view.layer insertSublayer:rippleLayer below:_button.layer];
    
    CGRect beginRect = _button.frame;
    CGRect endRect = CGRectInset(beginRect, -50, -50);
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:beginRect];

    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    rippleLayer.opacity = 0.0;
    rippleLayer.path = endPath.CGPath;
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = 2.0;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.6];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 2.0;
    
    [rippleLayer addAnimation:opacityAnimation forKey:@""];
    [rippleLayer addAnimation:rippleAnimation forKey:@""];
    
    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:2.0];
}

- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

/// 开始咻一咻动画
- (void)startXiuxiu:(UIButton *)button {
    [self addRippleLayer];
 
    // 1. 修改圆形视图背景颜色 61    107    147
    _circleView.backgroundColor = [UIColor colorWithRed:61 / 255.0 green:107 / 255.0 blue:147 / 255.0 alpha:1.0];
    
    // 2. 禁用按钮
    button.enabled = NO;
    
    CGFloat delay = 1.0;
    CGFloat scale = 8;
    NSInteger count = 20;
    
    // 3. 循环添加多个视图动画
    for (NSInteger i = 0; i < count; i++) {
        // 3. 创建一个圆形视图，添加到视图的底层
        UIView *animationView = [self circleView];
        animationView.backgroundColor = _circleView.backgroundColor;
        [self.view insertSubview:animationView atIndex:0];
        
        [UIView animateWithDuration:5 delay:i * delay options:UIViewAnimationOptionCurveLinear animations:^{
            animationView.transform = CGAffineTransformMakeScale(scale, scale);
            animationView.backgroundColor = self.view.backgroundColor;
            animationView.alpha = 0;
        } completion:^(BOOL finished) {
            [animationView removeFromSuperview];
            if (i == count - 1) {
                button.enabled = YES;
            }
        }];
    }
}

- (UIView *)circleView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = self.view.center;
    // 设置背景颜色 52     143    242
    view.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:143 / 255.0 blue:242 / 255.0 alpha:1.0];
    // 设置视图圆角
    view.layer.cornerRadius = 50.0;
    view.layer.masksToBounds = YES;
    return view;
}

@end
