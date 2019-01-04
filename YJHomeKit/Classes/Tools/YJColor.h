//
//  YJColor.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import <Foundation/Foundation.h>

@interface YJColor : NSObject

// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“0x123456” 、@“123456” 四种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  通过0xffffff的16进制数字创建颜色
 */
+ (UIColor *)colorWithRGB:(NSUInteger)aRGB;

//随机颜色
+ (UIColor *)randomColor;

+ (UIColor *)hex:(NSString *)hexString;

@end
