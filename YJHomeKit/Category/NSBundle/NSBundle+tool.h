//
//  NSBundle+tool.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import <Foundation/Foundation.h>

@interface NSBundle (tool)

+ (NSBundle *)bundleWithName:(NSString *)bundlename;

+ (NSBundle *)bundleWithClass:(Class)aClass pathForResource:(NSString *)resource;

@end
