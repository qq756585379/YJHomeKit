//
//  IMICommonTableViewCell.h
//  MiHome
//
//  Created by 杨俊 on 2017/10/17.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "YJTableViewCell.h"

@class YJCommonTableCell,YJCommonTableCellVO;

typedef enum {
    YJCommonTableCellTypeNone,
    YJCommonTableCellTypeArrow,
    YJCommonTableCellRightIcon,
    YJCommonTableCellTypeSwitch
}YJCommonTableCellType;

@interface YJCommonTableCellVO : NSObject
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *detailTitle;
@property (nonatomic,   copy) NSString *rightTitle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *rightImage;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) UITableViewCellStyle style;
@property (nonatomic, assign) YJCommonTableCellType cellType;// cell右边显示类型
@property (nonatomic,   copy) void(^clickBlock)(YJCommonTableCell *cell);
@property (nonatomic,   copy) void(^switchBlock)(NSIndexPath *indexPath,YJCommonTableCellVO *cellVO);
@end

@interface YJCommonTableCellGroup : NSObject
@property (nonatomic,   copy) NSString *header;
@property (nonatomic,   copy) NSString *footer;
@property (nonatomic, assign) CGFloat  headerHeight;
@property (nonatomic, assign) CGFloat  footerHeight;
@property (nonatomic, strong) NSArray <YJCommonTableCellVO *> *items;
@end

@interface YJCommonTableCell : YJTableViewCell
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) YJCommonTableCellVO *cellVO;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
@end
