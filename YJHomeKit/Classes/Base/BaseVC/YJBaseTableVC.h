//
//  YJBaseTableVC.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJBaseVC.h"
#import "YJTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJBaseTableVC : YJBaseVC <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) YJTableView *tableView;

@end

NS_ASSUME_NONNULL_END
