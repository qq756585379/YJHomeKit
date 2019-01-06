//
//  YJBaseTableVC.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJViewController.h"
#import "YJTableView.h"

@interface YJTableViewController : YJViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) YJTableView *tableView;

@end

