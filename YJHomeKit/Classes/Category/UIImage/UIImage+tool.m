//
//  UIImage+tool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "UIImage+tool.h"

@implementation UIImage (tool)

/**
 *  返回圆形图片
 */
- (instancetype)yj_circleImage{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 绘制图片
    [self drawInRect:rect];
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)aColor
{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame
{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithName:(NSString *)name bundle:(NSBundle *)bundle ofType:(NSString *)type
{
    UIImage *image = nil;
    image = [[UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:type]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
