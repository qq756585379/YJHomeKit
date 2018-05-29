//
//  YJTestSettingController.m
//  Example
//
//  Created by 杨俊 on 2018/1/15.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJTestSettingController.h"
#import <YJHomeKit/YJHomeKit.h>

@interface YJTestSettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YJTableView *tableView;
@end

@implementation YJTestSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[YJTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(25, 0, 0, 0);
}

#pragma mark - UITableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
/*
 typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
 UITableViewCellStyleDefault,    // Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)（左边一张图 一个主题，不显示副主题）
 UITableViewCellStyleValue1,        // Left aligned label on left and right aligned label on right with blue text (Used in Settings)（左边一张图 一个主题，右边副主题）
 UITableViewCellStyleValue2,        // Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts) (没有图片，这个属性一般不用)
 UITableViewCellStyleSubtitle    // Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).（左边一张图 一个主题，下边副主题）
 };
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
        cell.imageView.image = [UIImage imageNamed:@"device_share_xiaomi"];
        cell.textLabel.text = @"xiaomi";
        cell.detailTextLabel.text = @"mijia";
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
        cell.imageView.image = [UIImage imageNamed:@"device_share_xiaomi"];
        cell.textLabel.text = @"xiaomi";
        cell.detailTextLabel.text = @"mijia device_share";
        return cell;
    }else if (indexPath.row == 2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell3"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
        cell.imageView.image = [UIImage imageNamed:@"device_share_xiaomi"];
        cell.textLabel.text = @"xiaomi";
        cell.detailTextLabel.text = @"mijia";
        return cell;
    }else if (indexPath.row == 3){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell4"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
        cell.imageView.image = [UIImage imageNamed:@"device_share_xiaomi"];
        cell.textLabel.text = @"xiaomi";
        cell.detailTextLabel.text = @"mijia device_share_xiaomidevi";
        return cell;
    }else{
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
#pragma mark - 返回头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"header";
}
#pragma mark - 返回尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"footer";
}
@end
