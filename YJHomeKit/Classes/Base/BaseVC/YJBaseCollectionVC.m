//
//  YJBaseCollectionVC.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJBaseCollectionVC.h"
#import "YJMacro.h"

@interface YJBaseCollectionVC ()
@property (nonatomic, strong) YJCollectionView *collectionView;
@end

@implementation YJBaseCollectionVC

- (void)loadView
{
    [super loadView];
    self.collectionView = [[YJCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self customLayout]];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    [collectionView.collectionViewLayout invalidateLayout];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)dealloc{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

-(UICollectionViewFlowLayout *)customLayout
{
    return [UICollectionViewFlowLayout new];
}

@end
