//
//  YJViewAspectProtocol.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/16.
//

#import <Foundation/Foundation.h>

@protocol YJViewAspectProtocol <NSObject>
@optional
/**
 为视图绑定 viewModel
 
 @param viewModel 要绑定的ViewModel
 @param params 额外参数
 */
- (void)bindViewModel:(id <YJViewAspectProtocol>)viewModel withParams:(NSDictionary *)params;

/**
 初始化额外数据
 */
- (void)yj_initializeForView;

/**
 初始化视图
 */
- (void)yj_createViewForView;

@end
