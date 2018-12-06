//
//  YJAlertSheet.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJAlertSheet.h"

@implementation YJAlertSheet

+ (void)actionSheetWithTitle:(NSString *)aTitle
                     message:(NSString *)aMessage
                     buttons:(NSArray *)buttons
                 selectIndex:(NSInteger)index
           cancelButtonTitle:(NSString *)aCancelButtonTitle
            andCompleteBlock:(YJActionSheetBlock)aBlock
{
    
    if (!aTitle)    aTitle=@"";
    if (!aMessage)  aMessage=@"";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:aTitle
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<buttons.count; i++) {
        UIAlertActionStyle style = (index == i) ? UIAlertActionStyleDestructive : UIAlertActionStyleDefault;
        [alert addAction:[UIAlertAction actionWithTitle:buttons[i] style:style handler:^(UIAlertAction *action) {
            aBlock(buttons[i],i);
        }]];
    }
    [alert addAction:[UIAlertAction actionWithTitle:aCancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[self window] rootViewController] presentViewController:alert animated:YES completion:nil];
        });
        
    } else {
        
        UIViewController *root = [self window].rootViewController;
        UIPopoverPresentationController *ppc = [alert popoverPresentationController];
        ppc.sourceView = root.view;
        ppc.sourceRect = CGRectMake((CGRectGetWidth(ppc.sourceView.bounds)-2)*0.5f,CGRectGetHeight(ppc.sourceView.bounds), 2, 2);
        ppc.permittedArrowDirections = UIPopoverArrowDirectionUp;
        dispatch_async(dispatch_get_main_queue(), ^{
            [root presentViewController:alert animated:YES completion:nil];
        });
    }
}

+ (UIWindow *) window
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window  == nil) {
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            window = [[UIApplication sharedApplication].delegate window];
        }
    }
    return window;
}

@end
