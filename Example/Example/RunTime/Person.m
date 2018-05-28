//
//  Person.m
//  Example
//
//  Created by 杨俊 on 2018/5/18.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)runing
{
    NSLog(@"+runing");
}

+ (void)run
{
    NSLog(@"+run");
}

- (void)run
{
    NSLog(@"%s", __func__);
}

- (void)sleep
{
    NSLog(@"%s", __func__);
}

@end
