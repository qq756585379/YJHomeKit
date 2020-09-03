//
//  YJArchiveData.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJArchiveData.h"
#import "YJFileManager.h"

@implementation YJArchiveData

/**
 *  功能:存档（缓存用户数据）
 */
+ (void)archiveDataInDoc:(id<NSCoding>)aData withFileName:(NSString *)aFileName
{
    NSString *documentPath = [YJFileManager appDocPath];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aData];
    [archiveData writeToFile:filePath atomically:NO];
}

/**
 *  功能:取档
 */
+ (id<NSCoding>)unarchiveDataInDocWithFileName:(NSString *)aFileName
{
    NSString *documentPath = [YJFileManager appDocPath];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

/**
 *  功能:存档到cache
 */
+ (void)archiveDataInCache:(id<NSCoding>)aData withFileName:(NSString *)aFileName
{
    NSString *documentPath = [YJFileManager appCachePath];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:aData];
    [archiveData writeToFile:filePath atomically:NO];
}

/**
 *  功能:取档，从cache中取文件
 */
+ (id<NSCoding>)unarchiveDataInCacheWithFileName:(NSString *)aFileName
{
    NSString *documentPath = [YJFileManager appCachePath];
    NSString *filePath = [documentPath stringByAppendingPathComponent:aFileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

/**
 *  功能:取档(获取系统数据，直接取档)
 */
+ (id<NSCoding>)unarchiveDataInMainBundleWithFileName:(NSString *)aFileName
{
    return [self unarchiveDataWithFileName:aFileName andBundleName:@""];
}

+ (id<NSCoding>)unarchiveDataWithFileName:(NSString *)aFileName andBundleName:(NSString *)aBundleName
{
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName && aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    NSString *resourcePath = [bundle resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:aFileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

@end
