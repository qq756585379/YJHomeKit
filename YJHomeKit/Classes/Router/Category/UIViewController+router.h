//
//  UIViewController+router.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/28.
//

#import <UIKit/UIKit.h>

@class YJMappingVO;

@interface UIViewController (router)

/**
 *  通过mappingvo的key创建vc
 */
+ (instancetype)createWithMappingVOKey:(NSString *)aKey extraData:(NSDictionary *)aParam;
/**
 *  通过mappingvo创建vc
 */
+ (instancetype)createWithMappingVO:(YJMappingVO *)aMappingVO extraData:(NSDictionary *)aParam;

@end
