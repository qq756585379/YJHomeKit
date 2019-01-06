//
//  NSObject+swizzle.m
//  OneStore
//
//  Created by Aimy on 14-1-2.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "NSObject+swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (swizzle)

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        return NO;
    }
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    method_setImplementation(origMethod, class_getMethodImplementation(self, altSel));
    return YES;
}

+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel{
    Class c = object_getClass((id)self);
    return [c overrideMethod:origSel withMethod:altSel];
}

+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel{
    Method origMethod =class_getInstanceMethod(self, origSel);
    if (!origMethod) {
        return NO;
    }
    Method altMethod =class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel{
    Class c = object_getClass((id)self);
    return [c exchangeMethod:origSel withMethod:altSel];
}

@end
