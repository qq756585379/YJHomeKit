//
//  YJViewIntercepter.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/16.
//

#import "YJViewIntercepter.h"
#import "YJViewAspectProtocol.h"
#import <Aspects/Aspects.h>

@implementation YJViewIntercepter

+ (void)load
{
    [super load];
    [YJViewIntercepter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static YJViewIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YJViewIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 代码方式唤起view
        [UIView aspect_hookSelector:@selector(initWithFrame:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, CGRect frame){
            [self _init:aspectInfo.instance withFrame:frame];
        }  error:nil];
        
        // xib方式唤起view
        [UIView aspect_hookSelector:@selector(initWithCoder:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, NSCoder *aDecoder){
            // 在此时 IBOut 中 view 都为空， 需要Hook awakeFromNib 方法
            [self _init:aspectInfo.instance withCoder:aDecoder];
        } error:nil];
        
        // xib方式唤起view
        [UIView aspect_hookSelector:@selector(awakeFromNib) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            // 这时候可以初始化视图
            [self _awakFromNib:aspectInfo.instance];
        } error:nil];
    }
    return self;
}

#pragma mark - Hook Methods
- (void)_init:(UIView <YJViewAspectProtocol>*)view withFrame:(CGRect)frame
{
    if ([view respondsToSelector:@selector(yj_initializeForView)]) {
        [view yj_initializeForView];
    }
    
    if ([view respondsToSelector:@selector(yj_createViewForView)]) {
        [view yj_createViewForView];
    }
}

- (void)_init:(UIView <YJViewAspectProtocol>*)view withCoder:(NSCoder *)aDecoder
{
    if ([view respondsToSelector:@selector(yj_initializeForView)]) {
        [view yj_initializeForView];
    }
}

- (void)_awakFromNib:(UIView <YJViewAspectProtocol>*)view
{
    if ([view respondsToSelector:@selector(yj_createViewForView)]) {
        [view yj_createViewForView];
    }
}

@end
