//
//  BaseViewController.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/4.
//

#import "YJBaseVC.h"

@interface YJBaseVC ()

@end

@implementation YJBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)cancelFirstResponse
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
    [self.view resignFirstResponder];
}

@end
