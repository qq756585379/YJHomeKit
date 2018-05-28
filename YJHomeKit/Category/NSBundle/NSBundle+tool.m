//
//  NSBundle+tool.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "NSBundle+tool.h"

@implementation NSBundle (tool)

+ (NSBundle *)bundleWithName:(NSString *)bundlename{
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:bundlename];
    if ([[NSFileManager defaultManager] fileExistsAtPath:frameworkBundlePath]){
        return [NSBundle bundleWithPath:frameworkBundlePath];
    }
    return nil;
}

+ (NSBundle *)bundleWithClass:(Class)aClass pathForResource:(NSString *)resource
{
    NSBundle *bundle = nil;
    bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:aClass] pathForResource:resource ofType:@"bundle"]];
    return bundle;
}

@end
