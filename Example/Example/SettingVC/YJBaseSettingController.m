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

/*
 typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
 UITableViewCellStyleDefault,    // Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)（左边一张图 一个主题，不显示副主题）
 UITableViewCellStyleValue1,        // Left aligned label on left and right aligned label on right with blue text (Used in Settings)（左边一张图 一个主题，右边副主题）
 UITableViewCellStyleValue2,        // Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts) (没有图片，这个属性一般不用)
 UITableViewCellStyleSubtitle    // Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).（左边一张图 一个主题，下边副主题）
 };
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[YJTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    YJCommonTableCellGroup *goup1 = [YJCommonTableCellGroup new];
    YJCommonTableCellGroup *goup2 = [YJCommonTableCellGroup new];
    YJCommonTableCellGroup *goup3 = [YJCommonTableCellGroup new];
    
    NSString *subTitle = @"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    
    YJCommonTableCellVO *vo00 = [YJCommonTableCellVO new];
    vo00.image = [UIImage imageNamed:@"device_share_xiaomi"];
    vo00.style = UITableViewCellStyleDefault;
    vo00.title = @"xiaomi";
    vo00.detailTitle = @"mijia";
    vo00.cellType = YJCommonTableCellTypeArrow;

    YJCommonTableCellVO *vo01 = [YJCommonTableCellVO new];
    vo01.image = [UIImage imageNamed:@"device_share_xiaomi"];
    vo01.style = UITableViewCellStyleValue1;
    vo01.title = @"xiaomi";
    vo01.detailTitle = @"mijia";
    vo01.cellType = YJCommonTableCellTypeArrow;
    
    YJCommonTableCellVO *vo02 = [YJCommonTableCellVO new];
    vo02.style = UITableViewCellStyleValue1;
    vo02.title = @"xiaomi";
    vo02.detailTitle = @"mijia";
    vo02.cellType = YJCommonTableCellTypeSwitch;
    
    YJCommonTableCellVO *vo03 = [YJCommonTableCellVO new];
    vo03.image = [UIImage imageNamed:@"device_share_xiaomi"];
    vo03.style = UITableViewCellStyleSubtitle;
    vo03.title = @"xiaomi";
    vo03.detailTitle = subTitle;
    vo03.cellType = YJCommonTableCellTypeSwitch;
    vo03.cellHeight = 200;
    
    YJCommonTableCellVO *vo04 = [YJCommonTableCellVO new];
    vo04.style = UITableViewCellStyleSubtitle;
    vo04.title = @"xiaomi";
    vo04.detailTitle = subTitle;
    vo04.cellType = YJCommonTableCellTypeSwitch;
    vo04.cellHeight = 200;
    
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
    YJCommonTableCellGroup *group = _dataArray[indexPath.section];
    YJCommonTableCellVO *model = group.items[indexPath.row];
    
    YJCommonTableCell *cell = [YJCommonTableCell cellWithTableView:tableView style:model.style];
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
    YJCommonTableCellGroup *group = _dataArray[indexPath.section];
    YJCommonTableCellVO *model = group.items[indexPath.row];
    return model.cellHeight;
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
