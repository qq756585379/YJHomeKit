//
//  YJBaseCollectionView.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJBaseCollectionView.h"
#import "YJBaseCollectionViewCell.h"
#import "YJBaseCollectionReusableView.h"

@implementation YJBaseCollectionView

- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[YJBaseCollectionViewCell class]]) {
        [(YJBaseCollectionViewCell *)cell setIndexPath:indexPath];
    }
    return cell;
}

- (id)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind
                         withReuseIdentifier:(NSString *)identifier
                                forIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [super dequeueReusableSupplementaryViewOfKind:elementKind
                                                           withReuseIdentifier:identifier
                                                                  forIndexPath:indexPath];
    if ([cell isKindOfClass:[YJBaseCollectionReusableView class]]) {
        [(YJBaseCollectionReusableView *)cell setIndexPath:indexPath];
    }
    return cell;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadData{
    [self.collectionViewLayout invalidateLayout];
    [super reloadData];
}

@end
