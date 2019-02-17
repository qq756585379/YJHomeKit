//
//  YJGlobalValue.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "YJGlobalValue.h"

@implementation YJGlobalValue

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id __singleton__ = nil;
    dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init{
    if (self = [super init]) {
        self.customerInfos = @{}.mutableCopy;
        self.messagerSessionInfos = @{}.mutableCopy;
    }
    return self;
}

- (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}
    
-(UIEdgeInsets)safeAreaInset{
    if (@available(iOS 11.0, *)) {
        if ([self keyWindow]) {
            return [self keyWindow].safeAreaInsets;
        }
    }
    return UIEdgeInsetsZero;
}
    
-(BOOL)isHairHead{
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return self.safeAreaInset.left > 0.0f;
    }else{
        return self.safeAreaInset.top > 20.0f;
    }
}

- (NSDate *)serverTime{
    //根据本地时间与服务器时间的差异 算出的当前服务器的时间
    _serverTime = [NSDate dateWithTimeIntervalSinceNow:self.dTime];
    return _serverTime;
}

/**
 *  功能:方法重写，保证返回不为nil
 */
- (NSString *)sessionId{
    if (_sessionId == nil) {
        return @"";
    } else {
        return _sessionId;
    }
}

- (NSNumber *)redRainH5Control {
    if (!_redRainH5Control) {
        _redRainH5Control = @(0);
    }
    return _redRainH5Control;
}

@end
