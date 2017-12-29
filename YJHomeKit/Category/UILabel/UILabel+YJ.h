//
//  UILabel+YJ.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/29.
//

#import <UIKit/UIKit.h>

@interface UILabel (YJ)

- (CGSize)yj_calculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

@end
