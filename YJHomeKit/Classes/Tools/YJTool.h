//
//  YJTool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/4.
//

#import <Foundation/Foundation.h>

@interface YJTool : NSObject

#pragma mark - 下划线
+ (void)yj_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color;

/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)yj_setUpLabel:(UILabel *)label content:(NSString *)content indentationFortheFirstLineWith:(CGFloat)emptylen;

/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)yj_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;

/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+(id)yj_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color;

/**
 竖线线
 
 @param view 竖线线
 */
+ (void)yj_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;

/**
 设置按钮的圆角
 
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+(id)yj_chageControlCircularWith:(id)anyControl
              AndSetCornerRadius:(NSInteger)radius
                  SetBorderWidth:(NSInteger)width
                  SetBorderColor:(UIColor *)borderColor
                canMasksToBounds:(BOOL)can;

#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)yj_calculateTextSizeWithText:(NSString *)text WithTextFont:(NSInteger)textFont WithMaxW:(CGFloat)maxW;

+ (CGSize)yj_calculateRectWithText:(NSString *)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

#pragma mark - 图片转base64编码
+ (NSString *)UIImageToBase64Str:(UIImage *) image;

#pragma mark - base64转图片
+ (UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr;

@end
