//
//  YJViewAspectProtocol.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/16.
//

#import <Foundation/Foundation.h>

/**
 为 ViewController 绑定方法协议
 */
@protocol YJViewControllerAspectProtocol <NSObject>
@required
/// 初始化数据
- (void)yj_initialDefaultsForController;

/// 绑定 vm
- (void)yj_bindViewModelForController;

/// 创建视图
- (void)yj_createViewForConctroller;

/// 配置导航栏
- (void)yj_configNavigationForController;

@end
