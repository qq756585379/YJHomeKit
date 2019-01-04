//
//  UIViewController+YJRoute.h
//  YJRouter
//
//  Created by 杨俊 on 2018/11/16.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YJMappingVO;
@class YJRouterData;

@interface UIViewController (YJRoute)

/**
 *  通过mappingvo创建vc
 */
+ (instancetype)createWithMappingVO:(YJMappingVO *)aMappingVO extraData:(NSDictionary *)aParam;

// 获取view当前所在controller
- (UIViewController *)yj_currentController;

- (id)yj_routerByData:(YJRouterData *)routeData extraData:(NSDictionary *)extraData;

@end
