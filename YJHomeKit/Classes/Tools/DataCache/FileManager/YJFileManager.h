//
//  YJFileManager.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define OTS_DOC_PATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]

@interface YJFileManager : NSObject

/**
 *  获得app文档目录
 *
 *  @return 目录地址
 */
+ (NSString *)appDocPath;

/**
 *  获得app文档目录
 *
 *  @return 目录地址
 */
+ (NSString *)appCachePath;

/**
 *  获得app的lib目录
 *
 *  @return lib目录地址
 */
+ (NSString *)appLibPath;

/**
 *  判断文件是否存在
 *
 *  @param aPath 地址
 *
 *  @return BOOL
 */
+ (BOOL)isFileExsit:(NSString *)aPath;
/**
 *  判断Doc目录中是否存在某文件
 *
 *  @param aPath 地址
 *
 *  @return BOOL
 */
+ (BOOL)isFileExsitInDoc:(NSString *)aPath;
/**
 *  判断bundle是否存在
 *
 *  @param aBundleName bundle名称
 *
 *  @return BOOL
 */
+ (BOOL)isBundleExsit:(NSString *)aBundleName;

@end

NS_ASSUME_NONNULL_END
