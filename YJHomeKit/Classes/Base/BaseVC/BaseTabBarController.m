//
//  BaseTabBarController.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import "BaseTabBarController.h"

@implementation BaseTabBarController

- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex
{
    if (!aVC) {
        return ;
    }
    NSMutableArray *viewControllers = self.viewControllers.mutableCopy;
    [viewControllers replaceObjectAtIndex:aIndex withObject:aVC];
    [self setViewControllers:viewControllers animated:NO];
}

- (BOOL)shouldAutorotate
{
    return self.selectedViewController ? [self.selectedViewController shouldAutorotate] : [super shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.selectedViewController ? [self.selectedViewController supportedInterfaceOrientations] : [super supportedInterfaceOrientations];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
