//
//  YJUserDefault.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import <Foundation/Foundation.h>

@interface YJUserDefault : NSObject

/**
 *  存储数据到userdefault
 */
+ (void)setValue:(id)anObject forKey:(NSString *)aKey;
/**
 *  从userdefault获取数据
 */
+ (id)getValueForKey:(NSString *)aKey;

/**
 *  存储 bool 值
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)aKey;

/**
 *  从userdefault获取数据
 */
+ (BOOL)getBoolValueForKey:(NSString *)aKey;

@end
