//
//  IMICommonTableViewCell.m
//  MiHome
//
//  Created by 杨俊 on 2017/10/17.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "YJCommonTableCell.h"

@implementation YJCommonTableCellVO

@end

@implementation YJCommonTableCellGroup

@end

@implementation YJCommonTableCell
{
    UISwitch    *_toggle;
    UIImageView *_rightIcon;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    YJTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.numberOfLines = 0;
        self.detailTextLabel.numberOfLines = 0;
        
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.font = [UIFont systemFontOfSize:12];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    if (self.cellVO.cellType == YJCommonTableCellTypeArrow){
        self.rightLabel.frame = CGRectMake(screenW - 135, 0, 100, self.frame.size.height);
    }else{
        self.rightLabel.frame = CGRectMake(screenW - 115, 0, 100, self.frame.size.height);
    }
}

-(void)setCellVO:(YJCommonTableCellVO *)cellVO{
    _cellVO = cellVO;
    
    self.imageView.image = cellVO.image;
    self.textLabel.text = cellVO.title;
    self.detailTextLabel.text = cellVO.detailTitle;
    self.rightLabel.text = cellVO.rightTitle;
    
    if (cellVO.cellType == YJCommonTableCellRightIcon) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (_rightIcon == nil) {
            _rightIcon =  [[UIImageView alloc] init];
        }
        _rightIcon.image = cellVO.rightImage;
        [_rightIcon sizeToFit];
        self.accessoryView = _rightIcon;
    }else if (cellVO.cellType == YJCommonTableCellTypeArrow){ //右边是箭头
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
    }else if (cellVO.cellType == YJCommonTableCellTypeSwitch){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_toggle == nil) {
            _toggle = [[UISwitch alloc] init];
            [_toggle addTarget:self action:@selector(handleToggleClick:) forControlEvents:UIControlEventValueChanged];
        }
        _toggle.on = cellVO.isOn;
        self.accessoryView = _toggle;
    }else{
        self.accessoryView = nil;
    }
}

-(void)handleToggleClick:(UISwitch *)sender{
    self.cellVO.isOn = sender.isOn;
    !self.cellVO.switchBlock ? : self.cellVO.switchBlock(self.indexPath,self.cellVO);
}

@end
