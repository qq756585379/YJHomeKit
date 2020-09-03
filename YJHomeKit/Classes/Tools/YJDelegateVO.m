//
//  YJDelegateVO.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/9.
//

#import "YJDelegateVO.h"

@implementation YJDelegateVO

- (instancetype)initWithSel:(SEL)sel data:(NSDictionary *)data {
    if (self = [super init]) {
        self.delmethod = sel;
        self.dataDcit = data;
        self.aSelector = NSStringFromSelector(sel);
    }
    return self;
}

- (instancetype)initWithSelector:(NSString *)selName data:(NSDictionary *)data {
    if (self = [super init]) {
        self.aSelector = selName;
        self.dataDcit = data;
        self.delmethod = NSSelectorFromString(selName);
    }
    return self;
}

- (instancetype)initWithSel:(SEL)sel subscriber:(id)subscriber {
    if (self = [super init]) {
        self.delmethod = sel;
        self.subscriber = subscriber;
    }
    return self;
}

//发布广播
- (void)broadCastTopicWithData:(NSDictionary *)data {
    if ([self.subscriber respondsToSelector:self.delmethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.subscriber performSelector:self.delmethod withObject:data];
#pragma clang diagnostic pop
    }
}

@end
