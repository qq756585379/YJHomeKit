//
//  UIBarButtonItem+YJ.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/5.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YJ)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target
                                action:(SEL)action title:(NSString *)title;

@end
