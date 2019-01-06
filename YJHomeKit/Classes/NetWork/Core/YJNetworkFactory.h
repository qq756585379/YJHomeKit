//
//  YJNetworkManager.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import <Foundation/Foundation.h>
#import "YJOperationManager.h"
#import "UIViewController+net.h"

@interface YJNetworkFactory : NSObject

@property(nonatomic, strong) NSMutableArray *operationManagers;

+ (instancetype)sharedInstance;

/**
 *  功能:产生一个operation manager,当owner销毁的时候一并销毁OTSOperationManager
 */
- (YJOperationManager *)generateOperationMangerWithOwner:(id)owner;

@end
