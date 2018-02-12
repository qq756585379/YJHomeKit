//
//  IMICommonTableViewCell.m
//  MiHome
//
//  Created by 杨俊 on 2017/10/17.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "YJCommonTableCell.h"
#import "YJMacro.h"
#import "YJTool.h"

@implementation YJCommonTableCellVO

-(UITableViewCellStyle)style{
    return _style ? _style : UITableViewCellStyleDefault;
}

-(YJCommonTableCellType)cellType{
    return _cellType ? _cellType : YJCommonTableCellTypeArrow;
}

-(CGFloat)cellHeight{
    return _cellHeight ? _cellHeight : 50;
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
        
        self.textLabel.numberOfLines = 0;
        self.detailTextLabel.numberOfLines = 0;

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
    
    self.imageView.image = cellVO.image;
    self.textLabel.text = cellVO.title;
    self.detailTextLabel.text = cellVO.detailTitle;
    
    if (cellVO.cellType == YJCommonTableCellRightIcon) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        if (_rightIcon == nil) {
            _rightIcon =  [[UIImageView alloc] init];
        }
        _rightIcon.image = cellVO.rightImage;
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
