//
//  CJSettingTableViewCell.m
//  WeiBo
//
//  Created by mac527 on 15/10/5.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSettingTableViewCell.h"
#import "CJSettingItem.h"

#import "CJSettingArrowItem.h"
#import "CJSettingSwitchItem.h"
#import "CJSettingLabelItem.h"
#import "CJBadegButton.h"

@interface CJSettingTableViewCell()

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) UILabel *labelView;

@property (strong, nonatomic) CJBadegButton *badgeButton;

//@property (weak, nonatomic) UIImageView *selectedBgView;

//@property (nonatomic, weak) UIImageView *bgView;

//@property (nonatomic, strong) UIImageView *lineView;

@end

@implementation CJSettingTableViewCell
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        [_labelView setFont:[UIFont systemFontOfSize:13]];
        [_labelView setTextColor:[UIColor lightGrayColor]];
    }
    return _labelView;
}
- (CJBadegButton *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[CJBadegButton alloc] init];
    }
    return _badgeButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        

        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}


- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)number
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 设置背景图片
    if (number == 1) { // 一组只有一行
        bgView.image = [UIImage resizedImageWithName:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
    }else if (indexPath.row == 0){ // 首行
        bgView.image = [UIImage resizedImageWithName:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImageWithName:@"common_card_top_background_highlighted"];
    }else if (indexPath.row == number - 1){ // 末行
        bgView.image = [UIImage resizedImageWithName:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImageWithName:@"common_card_bottom_background_highlighted"];
    }else{ // 中间
        bgView.image = [UIImage resizedImageWithName:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImageWithName:@"common_card_middle_background_highlighted"];
    }

}


/**
 *  初始化cell
 */
+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SettingCell";
    
    CJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 设置基本数据
- (void)setItem:(CJSettingItem *)item
{
    // 1.设置数据
    _item = item;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    // 2.设置右边控件
    
    if (item.badgeValue){
        self.accessoryView = self.badgeButton;
        self.badgeButton.badgeValue = item.badgeValue;
    }
    else if ([item isKindOfClass:[CJSettingArrowItem class]]) {
        self.accessoryView = self.arrowView;
    } else if ([item isKindOfClass:[CJSettingSwitchItem class]]){
        self.accessoryView = self.switchView;
    } else if ([item isKindOfClass:[CJSettingLabelItem class]]){
        CJSettingLabelItem *labelItem = (CJSettingLabelItem *)item;
        self.labelView.text = labelItem.text;
        self.labelView.size = [labelItem.text sizeWithAttributes:@{NSFontAttributeName:self.labelView.font}];
        self.accessoryView = self.labelView;
    } else {
        self.accessoryView = nil;
    }
    
}

#pragma mark -调整子控件位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}


@end
