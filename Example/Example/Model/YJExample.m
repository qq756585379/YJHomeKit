//
//  YJExample.m
//  Example
//
//  Created by 杨俊 on 2018/1/3.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJExample.h"

@implementation YJExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector {
    YJExample *example = [YJExample new];
    example.title = title;
    example.selector = NSSelectorFromString(selector);
    return example;
}

@end
