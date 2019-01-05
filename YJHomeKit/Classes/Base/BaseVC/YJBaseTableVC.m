//
//  YJBaseTableVC.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJBaseTableVC.h"
#import "YJMacro.h"

@interface YJBaseTableVC ()
@property (nonatomic, strong) YJTableView *tableView;
@end

@implementation YJBaseTableVC

- (void)loadView
{
    [super loadView];
    self.tableView = [[YJTableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
    self.tableView.sectionFooterHeight = 0.1;
    self.tableView.sectionHeaderHeight = 0.1;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = [self separatorStyle];
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

- (UITableViewCellSeparatorStyle)separatorStyle
{
    return UITableViewCellSeparatorStyleSingleLine;
}

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
