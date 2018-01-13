//
//  IMICommonTableViewCell.m
//  MiHome
//
//  Created by 杨俊 on 2017/10/17.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "YJCommonTableCell.h"

@implementation YJCommonTableCellVO

-(instancetype)initWithTitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                  rightTitle:(NSString *)rightTitle
                    cellType:(YJCommonTableCellType)cellType
                    selected:(BOOL)selected
                        isOn:(BOOL)isOn
{
    if (self = [super init]) {
        self.title = title;
        self.subTitle = subTitle;
        self.rightTitle = rightTitle;
        self.cellType = cellType;
        self.selected = selected;
        self.isOn = isOn;
    }
    return self;
}

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.numberOfLines = 0;
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.numberOfLines = 0;

        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = [UIColor whiteColor];
        self.backgroundView = bg;
        
        // 设置cell选中状态的背景色
        UIView *selBg = [[UIView alloc ]init];
        selBg.backgroundColor = [UIColor colorWithRed:238/255.0f green:234/255.0f blue:223/255.0f alpha:1.0];
        self.selectedBackgroundView = selBg;
    }
    return self;
}

-(void)setCellVO:(YJCommonTableCellVO *)cellVO{
    _cellVO = cellVO;
    
    if (cellVO.imageName && cellVO.imageName.length) {
        self.imageView.image = [UIImage imageNamed:cellVO.imageName];
    }else if (cellVO.image){
        self.imageView.image = cellVO.image;
    }else{
        self.imageView.image = nil;
    }
    
    self.textLabel.text = cellVO.title;
    self.detailTextLabel.text = cellVO.subTitle;
    
    if (cellVO.cellType == YJCommonTableCellRightIcon) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (_rightIcon == nil) {
            _rightIcon =  [[UIImageView alloc] init];
        }
        if (cellVO.rightImageName && cellVO.rightImageName.length) {
            _rightIcon.image = [UIImage imageNamed:cellVO.rightImageName];
        }else if (cellVO.rightImage){
            _rightIcon.image = cellVO.rightImage;
        }else{
            _rightIcon.image = nil;
        }
        self.accessoryView = _rightIcon;
    }else if (cellVO.cellType == YJCommonTableCellTypeArrow){ //右边是箭头
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
    }else if (cellVO.cellType == YJCommonTableCellTypeSwitch){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_toggle == nil) {
            _toggle = [[UISwitch alloc] init];
            [_toggle addTarget:self action:@selector(handleToggleClick:) forControlEvents:UIControlEventValueChanged];
        }
        _toggle.on = cellVO.isOn;
        self.accessoryView = _toggle;
    }else if (cellVO.cellType == YJCommonTableCellTypeJustLabel){
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (_rightLabel == nil) {
            _rightLabel = [[UILabel alloc] init];
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            _rightLabel.frame = CGRectMake(screenW - 130, 0, 100, self.frame.size.height);
            [self.contentView addSubview:_rightLabel];
            _rightLabel.textAlignment = NSTextAlignmentRight;
            _rightLabel.font = [UIFont systemFontOfSize:14];
            _rightLabel.textColor = [UIColor blackColor];
            _rightLabel.numberOfLines = 0;
        }
        _rightLabel.text = cellVO.rightTitle;
    }else if (cellVO.cellType == YJCommonTableCellTypeLabelArrow){
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator; //使用原生箭头
        if (_rightLabel == nil) {
            _rightLabel = [[UILabel alloc] init];
            CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
            _rightLabel.frame = CGRectMake(screenW - 130, 0, 100, self.frame.size.height);
            [self.contentView addSubview:_rightLabel];
            _rightLabel.textAlignment = NSTextAlignmentRight;
            _rightLabel.font = [UIFont systemFontOfSize:14];
            _rightLabel.textColor = [UIColor blackColor];
            _rightLabel.numberOfLines = 0;
        }
        _rightLabel.text = cellVO.rightTitle;
    }else{
        self.accessoryView = nil;
    }
}

-(void)handleToggleClick:(UISwitch *)sender{
    self.cellVO.isOn = sender.isOn;
    !self.cellVO.switchBlock ? : self.cellVO.switchBlock(self.indexPath,self.cellVO);
}

@end
