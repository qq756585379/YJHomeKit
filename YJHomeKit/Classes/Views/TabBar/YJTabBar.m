//
//  YJTabBar.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/2/27.
//

#import "YJTabBar.h"
#import "Masonry.h"
#import "UIView+YJ.h"
#import "PureLayout.h"
#import "YJTabBarItem.h"

@interface YJTabBar () <YJTabBarItemDelegate>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation YJTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    self.backgroundView = [UIView autolayoutView];
    [self addSubview:self.backgroundView];
    [self.backgroundView autoPinEdgesToSuperviewEdges];
    
    self.backgroundImageView = [UIImageView autolayoutView];
    [self.backgroundView addSubview:self.backgroundImageView];
    [self.backgroundImageView autoPinEdgesToSuperviewEdges];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    self.backgroundImageView.image = backgroundImage;
}

- (void)setItems:(NSArray <YJTabBarItem *>*)items
{
    [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _items = [items copy];
    self.selectedItem = _items[0];
    
    for (YJTabBarItem *item in _items) {
        item.tag = [_items indexOfObject:item];
        [self addSubview:item];
        item.delegate = self;
        item.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [_items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [_items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
    }];
}

- (void)setSelectedItem:(YJTabBarItem *)selectedItem
{
    if (_selectedItem == selectedItem) {
        _selectedItem.selected = YES;
        return ;
    }
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
    _selectedItem.selected = YES;
}

- (NSUInteger)selectedIndex
{
    return self.selectedItem.tag;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTabBar:didSelectItem:)]) {
        [self.delegate customTabBar:self didSelectItem:_items[selectedIndex]];
    }
}

#pragma mark - YJTabBarItemDelegate
- (void)tabBarItemDidSelectItem:(YJTabBarItem *)item
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customTabBar:didSelectItem:)]) {
        [self.delegate customTabBar:self didSelectItem:item];
    }
}

@end
