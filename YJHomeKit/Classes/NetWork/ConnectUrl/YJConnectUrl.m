//
//  YJConnectUrl.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "YJConnectUrl.h"

@implementation YJConnectUrl

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id __singleton__ = nil;
    dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

@end
