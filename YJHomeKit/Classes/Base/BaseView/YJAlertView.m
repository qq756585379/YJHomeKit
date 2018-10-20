//
//  YJAlertView.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJAlertView.h"

@implementation YJAlertView

+ (void)alertWithMessage:(NSString *)aMessage
        andCompleteBlock:(YJAlertViewBlock)aBlock
{
    [self alertWithTitle:nil message:aMessage andCompleteBlock:aBlock];
}

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
      andCompleteBlock:(YJAlertViewBlock)aBlock
{
    [self alertWithTitle:aTitle message:aMessage leftBtn:nil rightBtn:@"确定" andCompleteBlock:aBlock];
}

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
               leftBtn:(NSString *)leftBtnName
              rightBtn:(NSString *)rightBtnName
      andCompleteBlock:(YJAlertViewBlock)aBlock
{
    if (!aMessage) aMessage=@"";
    if (!aTitle) aTitle=@"";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:aTitle
                                                                             message:aMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftBtnName)
    {
        UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:leftBtnName
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {
                                                                 if (aBlock) aBlock(0);
                                                             }];
        [alertController addAction:cancelButton];
    }
    
    if (rightBtnName)
    {
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:rightBtnName
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             if (aBlock) aBlock(1);
                                                         }];
        [alertController addAction:okButton];
    }
    
    [[[self window] rootViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (UIWindow *) window {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window  == nil) {
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            window = [[UIApplication sharedApplication].delegate window];
        }
    }
    return window;
}

@end
