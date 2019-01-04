//
//  NSString+YJRoute.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/18.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "NSString+YJRoute.h"

@implementation NSString (YJRoute)

// http://www.testurl.com:8080/subpath/subsubpath?uid=123&gid=456
// url.query = "uid=123&gid=456"
+ (NSDictionary *)getDictFromUrl:(NSURL *)url
{
    NSString *dataStr = [NSString stringWithFormat:@"%@",url.query];
    NSArray *keyValues = [dataStr componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = @{}.mutableCopy;
    [keyValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:[obj componentsSeparatedByString:@"="].lastObject forKey:[obj componentsSeparatedByString:@"="].firstObject];
    }];
    return dic;
}

@end
