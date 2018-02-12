//
//  YJViewAspectProtocol.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/16.
//

#import <Foundation/Foundation.h>

@protocol YJViewModelAspectProtocol <NSObject>
@required

/**
 viewModel 初始化属性
 */
- (void)yj_initializeForViewModel;

@end

