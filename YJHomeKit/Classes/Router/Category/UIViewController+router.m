//
//  UIViewController+router.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/28.
//

#import "UIViewController+router.h"
#import "YJRouter.h"

@implementation UIViewController (router)

+ (instancetype)createWithMappingVOKey:(NSString *)aKey extraData:(NSDictionary *)aParam
{
    return [self createWithMappingVO:[YJRouter sharedInstance].mapping[aKey] extraData:aParam];
}

+ (instancetype)createWithMappingVO:(YJMappingVO *)aMappingVO extraData:(NSDictionary *)aParam
{
    if (aMappingVO.className == nil) {
        NSLog(@"error %@, className is nil",aMappingVO.description);
        return nil;
    }
    
    Class class = NSClassFromString(aMappingVO.className);
    if (!class) {
        NSLog(@"error %@, no such class",aMappingVO);
        return nil;
    }
    
    UIViewController *vc = nil;
    aParam = aParam ? : @{};
    aMappingVO.extraData = aParam;
    
    if (aMappingVO.createdType == IMIMappingClassCreateByCode) {
        vc = [[class alloc] initWithNibName:nil bundle:nil];
    }
    else if (aMappingVO.createdType == IMIMappingClassCreateByXib) {
        NSBundle *bundle = [self getBundleWithBundleName:aMappingVO.bundleName];
        vc = [[class alloc] initWithNibName:aMappingVO.nibName bundle:bundle];
    }
    else if (aMappingVO.createdType == IMIMappingClassCreateByStoryboard) {
        NSBundle *bundle = [self getBundleWithBundleName:aMappingVO.bundleName];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aMappingVO.storyboardName bundle:bundle];
        vc = [storyboard instantiateViewControllerWithIdentifier:aMappingVO.storyboardID];
    }
    
    return vc;
}

+ (NSBundle *)getBundleWithBundleName:(NSString *)aBundleName
{
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    return bundle;
}

@end
