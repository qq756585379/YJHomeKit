//
//  YJArchiveData.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJArchiveData : NSObject

/**
 *  功能:存档
 */
+ (void)archiveDataInDoc:(id<NSCoding>)aData withFileName:(NSString *)aFileName;

/**
 *  功能:取档，从document中取文件
 */
+ (id<NSCoding>)unarchiveDataInDocWithFileName:(NSString *)aFileName;

/**
 *  功能:存档到cache
 */
+ (void)archiveDataInCache:(id<NSCoding>)aData withFileName:(NSString *)aFileName;

/**
 *  功能:取档，从cache中取文件
 */
+ (id<NSCoding>)unarchiveDataInCacheWithFileName:(NSString *)aFileName;

/**
 *  功能:取档,从[[NSBundle mainBundle] resourcePath]取文件
 */
+ (id<NSCoding>)unarchiveDataInMainBundleWithFileName:(NSString *)aFileName;

/**
 *  功能:取档,从[[NSBundle mainBundle] resourcePath]取文件
 */
+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName andBundleName:(NSString *)aBundleName;

@end

NS_ASSUME_NONNULL_END
