//
//  YJMappingVO.m
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import "YJMappingVO.h"

@implementation YJMappingVO

- (NSString *)nibName
{
    if (!_nibName) {
        return self.className;
    }
    return _nibName;
}

- (NSString *)storyboardID
{
    if (!_storyboardID) {
        return self.className;
    }
    return _storyboardID;
}

- (NSString *)storyboardName
{
    if (!_storyboardName) {
        return @"Main";
    }
    return _storyboardName;
}

- (YJRouteType)routeType
{
    if (!_routeType) {
        return YJRouteTypePush;
    }
    return _routeType;
}

@end
