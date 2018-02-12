//
//  ViewController.m
//  Example
//
//  Created by 杨俊 on 2017/12/20.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <YJHomeKit/YJHomeKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <PureLayout/PureLayout.h>
#import "YJExample.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) YJRefreshHeader *refreshHeaderView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSDate *lastUpdateDate;
@property (nonatomic, strong) NSArray<YJExample *>*examples;
@property (nonatomic, strong) UIView *fullView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self refreshHeaderView];
    [self configData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)configData{
    self.examples = @[[YJExample exampleWithTitle:@"YJPhotoToolVC" selector:@"YJPhotoToolVC"],
                      [YJExample exampleWithTitle:@"YJWebViewController" selector:@"YJWebViewController"],
                      [YJExample exampleWithTitle:@"YJBaseSettingController" selector:@"YJBaseSettingController"],
                      [YJExample exampleWithTitle:@"YJTestSettingController" selector:@"YJTestSettingController"],
                      [YJExample exampleWithTitle:@"JavaScriptCore" selector:@"JavaScriptCore"],
                      [YJExample exampleWithTitle:@"JavaScriptCore" selector:@"JavaScriptCore"],
                      [YJExample exampleWithTitle:@"MiHome" selector:@"MiHomeUI"],
                      [YJExample exampleWithTitle:@"X" selector:@"___X"],
                      [YJExample exampleWithTitle:@"playSound" selector:@"playSound"],
                      [YJExample exampleWithTitle:@"AVPlayer" selector:@"aVPlayerExample"]];
    [self.tableView reloadData];
}

-(void)YJTestSettingController{
    [self.navigationController pushViewController:[NSClassFromString(@"YJTestSettingController") new] animated:YES];
}

-(void)YJBaseSettingController{
    [self.navigationController pushViewController:[NSClassFromString(@"YJBaseSettingController") new] animated:YES];
}

-(void)YJPhotoToolVC{
    [self.navigationController pushViewController:[NSClassFromString(@"YJPhotoToolVC") new] animated:YES];
}

-(void)YJWebViewController{
    [self.navigationController pushViewController:[NSClassFromString(@"YJWebViewController") new] animated:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.examples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YJExampleCell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = self.view.tintColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJExample *example = self.examples[indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
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

-(UITableView *)tableView{
    if (!_tableView){
        CGRect rect = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - SAFE_AREA_BOTTOM - NAV_BAR_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"YJExampleCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
