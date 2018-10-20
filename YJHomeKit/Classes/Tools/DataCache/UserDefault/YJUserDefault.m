//
//  YJUserDefault.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "YJUserDefault.h"

@implementation YJUserDefault

+ (void)setValue:(id)anObject forKey:(NSString *)aKey{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    if (anObject){
        [[NSUserDefaults standardUserDefaults] setObject:anObject forKey:aKey];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:aKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getValueForKey:(NSString *)aKey{
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)aKey {
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:aKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getBoolValueForKey:(NSString *)aKey {
    if ( ! aKey || ! [aKey isKindOfClass:[NSString class]]) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:aKey];
}

@end
