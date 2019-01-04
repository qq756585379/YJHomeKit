//
//  YJRouterData.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/17.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "YJRouterData.h"

@implementation YJRouterData

+ (instancetype)initWithType:(YJRouteType)type destVc:(NSString *)destVc{
    YJRouterData *a =  [[self alloc] init];
    a.routeType = type;
    a.destVc = destVc;
    return a;
}

@end
