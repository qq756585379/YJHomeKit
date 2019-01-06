//
//  YJConnectUrl.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import <Foundation/Foundation.h>

@interface YJConnectUrl : NSObject

@property (nonatomic,   copy) NSString *domain;

+ (instancetype)sharedInstance;

@end
