//
//  YJBaseSettingController.m
//  Example
//
//  Created by 杨俊 on 2018/1/13.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJBaseSettingController.h"
#import <YJHomeKit/YJHomeKit.h>
#import "YJCommonTableCell.h"

@interface YJBaseSettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YJTableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation YJBaseSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[YJTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
//    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    YJCommonTableCellGroup *goup1 = [YJCommonTableCellGroup new];
    YJCommonTableCellGroup *goup2 = [YJCommonTableCellGroup new];
    YJCommonTableCellGroup *goup3 = [YJCommonTableCellGroup new];
    
    NSString *subTitle = @"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    YJCommonTableCellVO *vo00 = [[YJCommonTableCellVO alloc] initWithTitle:@"000"
                                                                  subTitle:subTitle
                                                                rightTitle:@"000"
                                                                  cellType:YJCommonTableCellTypeSwitch
                                                                  selected:NO
                                                                      isOn:YES];

    YJCommonTableCellVO *vo01 = [[YJCommonTableCellVO alloc] initWithTitle:@"01"
                                                                  subTitle:@"01"
                                                                rightTitle:@"01"
                                                                  cellType:YJCommonTableCellTypeLabelArrow
                                                                  selected:NO
                                                                      isOn:NO];
    
    YJCommonTableCellVO *vo02 = [[YJCommonTableCellVO alloc] initWithTitle:@"02"
                                                                  subTitle:@"02"
                                                                rightTitle:@"02"
                                                                  cellType:YJCommonTableCellTypeArrow
                                                                  selected:NO
                                                                      isOn:NO];
    YJCommonTableCellVO *vo03 = [YJCommonTableCellVO new];
    YJCommonTableCellVO *vo04 = [YJCommonTableCellVO new];
    YJCommonTableCellVO *vo05 = [YJCommonTableCellVO new];
    
    YJCommonTableCellVO *vo10 = [YJCommonTableCellVO new];
    
    YJCommonTableCellVO *vo20 = [YJCommonTableCellVO new];
    
    goup1.items = @[vo00,vo01,vo02,vo03,vo04,vo05];
    goup2.items = @[vo10];
    goup3.items = @[vo20];
    self.dataArray = @[goup1,goup2,goup3];
}

#pragma mark - UITableView的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YJCommonTableCellGroup *group = _dataArray[section];
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YJCommonTableCell *cell = [YJCommonTableCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    YJCommonTableCellGroup *group = _dataArray[indexPath.section];
    YJCommonTableCellVO *model = group.items[indexPath.row];
    cell.cellVO = model;
    return cell;
}

// cell的点击监听事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YJCommonTableCellGroup *group = _dataArray[indexPath.section];
    YJCommonTableCellVO *model = group.items[indexPath.row];
    !model.clickBlock ? : model.clickBlock(nil);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark - 返回头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YJCommonTableCellGroup *group = _dataArray[section];
    return group.header;
}

#pragma mark - 返回尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    YJCommonTableCellGroup *group = _dataArray[section];
    return group.footer;
}

@end
