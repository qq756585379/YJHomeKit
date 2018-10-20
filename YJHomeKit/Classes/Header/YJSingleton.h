//
//  IMISingleton.h
//  TuyaSmartCamera
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 tuya. All rights reserved.
//

// .h文件
#undef  YJ_SINGLETON_H
#define YJ_SINGLETON_H +(instancetype)sharedInstance;

// .m文件
#undef  YJ_SINGLETON_M
#define YJ_SINGLETON_M \
static id _instance = nil; \
+(id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+(instancetype)sharedInstance \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
-(id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}
