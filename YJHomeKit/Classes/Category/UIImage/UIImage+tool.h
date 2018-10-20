//
//  UIImage+tool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import <UIKit/UIKit.h>

@interface UIImage (tool)

/**
 *  返回圆形图片
 */
- (instancetype)yj_circleImage;

+ (UIImage *)imageWithName:(NSString *)name bundle:(NSBundle *)bundle ofType:(NSString *)type;

@end
