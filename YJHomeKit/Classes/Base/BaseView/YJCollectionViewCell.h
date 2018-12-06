//
//  YJBaseCollectionViewCell.h
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import <UIKit/UIKit.h>

@interface YJCollectionViewCell : UICollectionViewCell

/**
 *  index
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;

/**
 *  功能:获取cell对应的xib
 */
+ (UINib *)nib;

+ (UINib *)nibInBundle:(NSBundle *)bundle;

/**
 *    功能:cell根据数据显示ui
 */
- (void)updateWithCellData:(id)aData;

/**
 *    功能:cell根据数据和位置显示ui
 */
- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath;

/**
 *    功能:获取cell的大小
 */
+ (CGSize)sizeForCellData:(id)aData;

@end
