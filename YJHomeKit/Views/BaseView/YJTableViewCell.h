//
//  YJBaseTableViewCell.h
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import <UIKit/UIKit.h>

@interface YJTableViewCell : UITableViewCell
/**
 *  index
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  缩进边界
 */
@property (nonatomic) UIEdgeInsets cellEdgeInsets;
/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;
/**
 *    功能:cell根据数据显示ui
 */
- (void)updateWithCellData:(id)aData;
/**
 *  功能:获取cell的高度。如果要根据数据获取cell的高度，必须等数据填充完毕后,再调用此方法才有用
 */
- (CGFloat)getCellHeight;
/**
 *    功能:cell根据数据和位置显示ui
 */
- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;
/**
 *    功能:获取cell的高度
 */
+ (CGFloat)heightForCellData:(id)aData;
/**
 *    功能:获取cell的高度
 */
+ (CGFloat)heightForCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;
/**
 *  功能:返回Cell对应的nib
 */
+ (UINib *)nib;

@end
