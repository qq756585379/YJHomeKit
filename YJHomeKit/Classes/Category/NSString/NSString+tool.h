//
//  NSString+tool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/2.
//

#import <Foundation/Foundation.h>

@interface NSString (tool)

-(NSString *)yj_stringByAddingPercentEscapesUsingEncoding;
-(NSString *)yj_stringByReplacingPercentEscapesUsingEncoding;

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

-(BOOL)isPhoneNo;
-(BOOL)isEmail;

-(NSString *)stringFromDate:(NSDate *)dat format:(NSString *)format;

//获取首字母
- (NSString *)firstStringSeparatedByString:(NSString *)separeted;

+(NSString *) unicodeToUtf8:(NSString *)string;
+(NSString *) utf8ToUnicode:(NSString *)string;

@end
