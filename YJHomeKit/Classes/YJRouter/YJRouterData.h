//
//  YJRouterData.h
//  YJRouter
//
//  Created by 杨俊 on 2018/11/17.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YJRouteType) {
    YJRouteTypePush      = 0,   // push界面
    YJRouteTypePresent   = 1,   // 弹出界面
    YJRouteTypeFunction  = 2,   // 调用方法
};

@interface YJRouterData : NSObject

@property (strong, nonatomic) NSString *fromVc;

@property (strong, nonatomic) NSString *destVc;

@property (assign, nonatomic) YJRouteType routeType;

+ (instancetype)initWithType:(YJRouteType)type destVc:(NSString *)destVc;

@end

