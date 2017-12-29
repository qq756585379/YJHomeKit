//
//  ViewController.m
//  Example
//
//  Created by 杨俊 on 2017/12/20.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <YJHomeKit/YJMacro.h>
#import <YJHomeKit/YJRefreshHeader.h>
#import <YJHomeKit/NSObject+PerformBlock.h>
#import <PureLayout/PureLayout.h>

@interface ViewController ()<YJRefreshHeaderViewDelegate>
@property (strong, nonatomic) YJRefreshHeader *refreshHeaderView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSDate *lastUpdateDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 500) style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];

    self.tableView = tableView;
    
    [self refreshHeaderView];
}

- (void)_reloadHomePageData {
    WEAK_SELF;
    [self performInMainThreadBlock:^{
        STRONG_SELF;
        [self.refreshHeaderView refreshHeaderViewDataSourceDidFinishedLoading:self.tableView];
    } afterSecond:3.f];
}

#pragma mark - OTSRefreshHeaderViewDelegate
- (void)refreshHeaderViewDidTriggerRefresh:(YJRefreshHeader *)view {
    WEAK_SELF;
    [self performInMainThreadBlock:^{
        STRONG_SELF;
        [self _reloadHomePageData];
    } afterSecond:1.f];
}

- (NSDate *)refreshHeaderViewDataSourceLastUpdated:(YJRefreshHeader *)view {
    return self.lastUpdateDate;
}

-(YJRefreshHeader *)refreshHeaderView {
    if (!_refreshHeaderView) {
        _refreshHeaderView = [YJRefreshHeader addRefreshHeaderViewOnScrollView:self.tableView];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.delegate = self;
    }
    return _refreshHeaderView;
}


@end
