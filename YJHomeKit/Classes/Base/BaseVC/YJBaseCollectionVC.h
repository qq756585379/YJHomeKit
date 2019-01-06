//
//  YJBaseCollectionVC.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJViewController.h"
#import "YJCollectionView.h"

@interface YJBaseCollectionVC : YJViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong, readonly) YJCollectionView *collectionView;

@end

