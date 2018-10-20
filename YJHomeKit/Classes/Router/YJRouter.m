//
//  YJRouter.m
//  Pods
//
//  Created by 杨俊 on 2018/5/28.
//

#import "YJRouter.h"
#import "YJMacro.h"

@interface YJRouter ()
@property (nonatomic, strong) NSArray *tabArray;
@property (nonatomic, strong) NSString *appScheme;
@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) NSMutableDictionary *mapping;
@property (nonatomic, strong) UIViewController *pcContainer;
@end

@implementation YJRouter

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id __singleton__ = nil;
    dispatch_once(&once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init{
    if (self = [super init]) {
        NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
        NSLog(@"bundleIdentifier == %@",bundleIdentifier);
        self.mapping = [NSMutableDictionary dictionary];
        self.appScheme = @"localhost";
    }
    return self;
}

#pragma mark - Register
- (void)registerRootVC:(UIViewController *)aRootVC
{
    if (self.rootVC) {
        NSLog(@"已经设置了rootvc，不能重复设置");
        return ;
    }
    self.rootVC = aRootVC;
}

- (void)registerTabArray:(NSArray *)aTabArray
{
    if (self.tabArray) {
        NSLog(@"已经设置了tabarray，不能重复设置");
        return ;
    }
    self.tabArray = aTabArray;
}

- (void)registerPCContainer:(UIViewController *)aPCContainer
{
    if (self.pcContainer) {
        NSLog(@"已经设置了pc Container，不能重复设置");
        return ;
    }
    self.pcContainer = aPCContainer;
}

- (void)registerRouterVO:(YJMappingVO *)aVO withKey:(NSString *)aKeyName
{
    if (IS_IPHONE_DEVICE && aVO.loadFilterType == IMIMappingClassPlatformTypePad) {
        return;
    } else if (IS_IPAD_DEVICE && aVO.loadFilterType == IMIMappingClassPlatformTypePhone) {
        return;
    }
    if (self.mapping[aKeyName]) {
        NSLog(@"overwrite router vo key[%@], mapping vo,%@", aKeyName, self.mapping[aKeyName]);
    }
    self.mapping[aKeyName] = aVO;
}

@end
