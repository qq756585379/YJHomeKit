//
//  YJExample.h
//  Example
//
//  Created by 杨俊 on 2018/1/3.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJExample : NSObject

@property (nonatomic,   copy) NSString *title;
@property (nonatomic, assign) SEL selector;

+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector;

@end
