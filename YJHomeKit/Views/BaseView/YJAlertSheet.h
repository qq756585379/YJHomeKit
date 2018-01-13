//
//  YJAlertSheet.h
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import <Foundation/Foundation.h>

typedef void(^YJActionSheetBlock)(NSString *title,NSInteger index);

@interface YJAlertSheet : NSObject

+ (void)actionSheetWithTitle:(NSString *)aTitle
                     message:(NSString *)aMessage
                     buttons:(NSArray *)buttons
                 selectIndex:(NSInteger)index
           cancelButtonTitle:(NSString *)aCancelButtonTitle
            andCompleteBlock:(YJActionSheetBlock)aBlock;

@end
