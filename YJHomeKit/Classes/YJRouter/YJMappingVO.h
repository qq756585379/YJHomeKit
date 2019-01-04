//
//  YJMappingVO.h
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IMIMappingClassCreateType){
    IMIMappingClassCreateByCode       = 0,//编码方式创建
    IMIMappingClassCreateByXib        = 1,//xib方式创建
    IMIMappingClassCreateByStoryboard = 2,//storyboard方式创建
};

typedef NS_ENUM(NSUInteger, IMIMappingClassPlatformType){
    IMIMappingClassPlatformTypePhone     = 0,//只在iPhone上load
    IMIMappingClassPlatformTypePad       = 1,//只在iPad上load
    IMIMappingClassPlatformTypeUniversal = 2,//任何平台都load
};

@interface YJMappingVO : NSObject

/**
 *  创建的类名
 */
@property (nonatomic, strong) NSString *className;

/**
 *  创建的方式
 */
@property (nonatomic) IMIMappingClassCreateType createdType;

/**
 *  load过滤
 */
@property (nonatomic) IMIMappingClassPlatformType loadFilterType;

/**
 *  资源文件存放的bundle名称
 */
@property (nonatomic, strong) NSString *bundleName;

/**
 *  资源文件名称
 */
@property (nonatomic, strong) NSString *nibName;

/**
 *  storyboard名称
 */
@property (nonatomic, strong) NSString *storyboardName;

/**
 *  storyboard中storyboardID名称
 */
@property (nonatomic, strong) NSString *storyboardID;

/**
 *  YES 就是present呈现界面，NO就是push界面
 */
@property (nonatomic, assign) BOOL isPC;

@property (nonatomic, assign) BOOL forceDismissed;

@end

