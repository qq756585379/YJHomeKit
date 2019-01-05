//
//  YJTableHeaderFooterView.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJTableHeaderFooterView : UITableViewHeaderFooterView

+(instancetype)tableHeaderWithTableView:(UITableView *)tv;

/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;

/**
 *    功能:cell根据数据显示ui
 */
- (void)updateWithCellData:(id)aData;

/**
 *    功能:获取cell的高度
 */
+ (CGFloat)heightForCellData:(id)aData;

@end

NS_ASSUME_NONNULL_END
