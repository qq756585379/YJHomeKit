//
//  UIViewController+loading.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/6.
//

#import "UIViewController+loading.h"
#import "MBProgressHUD.h"

@implementation UIViewController (loading)

- (void)showLoading
{
    [self showLoadingWithMessage:nil];
}

- (void)showLoadingWithMessage:(NSString *)message
{
    [self showLoadingWithMessage:message hideAfter:0];
}

- (void)showLoadingWithMessage:(NSString *)message hideAfter:(NSTimeInterval)second
{
    [self showLoadingWithMessage:message onView:self.view hideAfter:second];
}

- (void)showLoadingWithMessage:(NSString *)message onView:(UIView *)aView hideAfter:(NSTimeInterval)second
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    if (message) {
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:12];
        hud.mode = MBProgressHUDModeText;
    }else {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    if (second > 0) {
        [hud hideAnimated:YES afterDelay:second];
    }
}

- (void)hideLoading
{
    [self hideLoadingOnView:self.view];
}

- (void)hideLoadingOnView:(UIView *)aView
{
    [MBProgressHUD hideHUDForView:aView animated:YES];
}

- (void)showNonModelLoading
{
//    [OTSNonModelLoadingView showLoadingAddedTo:self.view animated:YES];
}

- (void)hideNonModelLoading
{
//    [OTSNonModelLoadingView hideLoadingForView:self.view animated:YES];
}

@end
