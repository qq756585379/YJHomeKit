//
//  IMIRegisterCenter.h
//  IMIHome
//
//  Created by 杨俊 on 2018/5/7.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJDelegateVO.h"

@interface YJRegisterCenter : NSObject

+(instancetype)sharedInstance;

//注册广播服务
-(void)registTopicWithDelegateVO:(YJDelegateVO *)delegateVO withKey:(NSString *)aKey;

-(void)unRegistTopicWithKey:(NSString *)aKey;

//发布广播
-(void)broadCastTopicWithData:(NSDictionary *)data;

@end
