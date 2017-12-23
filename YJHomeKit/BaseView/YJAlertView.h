//
//  YJAlertView.h
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import <Foundation/Foundation.h>

typedef void(^YJAlertViewBlock)(NSInteger buttonIndex);

@interface YJAlertView : NSObject

+ (void)alertWithMessage:(NSString *)aMessage
        andCompleteBlock:(YJAlertViewBlock)aBlock;

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
      andCompleteBlock:(YJAlertViewBlock)aBlock;

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
               leftBtn:(NSString *)leftBtnName
              rightBtn:(NSString *)rightBtnName
      andCompleteBlock:(YJAlertViewBlock)aBlock;

@property (nonatomic, copy) YJAlertViewBlock block;

@end
