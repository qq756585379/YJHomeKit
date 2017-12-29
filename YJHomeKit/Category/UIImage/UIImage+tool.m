//
//  UIImage+tool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "UIImage+tool.h"

@implementation UIImage (tool)

+ (UIImage *)imageWithName:(NSString *)name bundle:(NSBundle *)bundle ofType:(NSString *)type
{
    UIImage *image = nil;
    image = [[UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:type]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
