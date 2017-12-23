//
//  YJBaseTableViewCell.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJBaseTableViewCell.h"

@implementation YJBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    CGRect rc = CGRectMake(frame.origin.x + self.cellEdgeInsets.left, frame.origin.y + self.cellEdgeInsets.top,
                           frame.size.width - self.cellEdgeInsets.left - self.cellEdgeInsets.right,
                           frame.size.height - self.cellEdgeInsets.top - self.cellEdgeInsets.bottom);
    [super setFrame:rc];
}

+ (NSString *)cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

- (void)updateWithCellData:(id)aData
{
    
}

- (void)updateWithCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath
{
    
}

+ (CGFloat)heightForCellData:(id)aData
{
    return 0;
}

- (CGFloat)getCellHeight{
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

+ (CGFloat)heightForCellData:(id)aData atIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

//这个方法如果滥用，会很恐怖。。。所以不能公开
- (UITableView *)__getTableView{
    static int level = 10;
    UITableView *tableView = nil;
    
    UIView *view = self.superview;
    for (int i = 0; i < level; i++) {
        if ([view isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)view;
            break;
        }
        if (view.superview) {
            view = view.superview;
        }else {
            break;
        }
    }
    return tableView;
}

- (NSIndexPath *)indexPath{
    if (_indexPath) {
        return _indexPath;
    }
    _indexPath = [[self __getTableView] indexPathForCell:self];
    return _indexPath;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (UINib *)nib{
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

@end
