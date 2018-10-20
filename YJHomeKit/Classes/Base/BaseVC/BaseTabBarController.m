//
//  BaseTabBarController.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)shouldAutorotate{
    return self.selectedViewController ? [self.selectedViewController shouldAutorotate] : [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return self.selectedViewController ? [self.selectedViewController supportedInterfaceOrientations] : [super supportedInterfaceOrientations];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
