//
//  NSDate+YJ.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/4/14.
//

#import "NSDate+YJ.h"

@implementation NSDate (YJ)

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

@end
