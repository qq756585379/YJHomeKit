//
//  IMIRegisterCenter.m
//  IMIHome
//
//  Created by 杨俊 on 2018/5/7.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJRegisterCenter.h"

@interface YJRegisterCenter()
@property (nonatomic, strong) NSMutableSet *topicSet;
@property (nonatomic, strong) NSMutableDictionary *topicDict;
@end

@implementation YJRegisterCenter

+(instancetype)sharedInstance
{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//注册广播服务
-(void)registTopicWithDelegateVO:(YJDelegateVO *)delegateVO withKey:(NSString *)aKey
{
    if (!aKey)  return;
    if (!delegateVO) return;
    [self.topicDict setObject:delegateVO forKey:aKey];
}

-(void)unRegistTopicWithKey:(NSString *)aKey
{
    [self.topicDict removeObjectForKey:aKey];
}

//发布广播
-(void)broadCastTopicWithData:(NSDictionary *)data
{
    [self.topicDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        YJDelegateVO *delegateVO = obj;
        [delegateVO broadCastTopicWithData:data];
    }];
}

-(NSMutableDictionary *)topicDict{
    if (!_topicDict) {
        _topicDict = [NSMutableDictionary dictionary];
    }
    return _topicDict;
}

@end
