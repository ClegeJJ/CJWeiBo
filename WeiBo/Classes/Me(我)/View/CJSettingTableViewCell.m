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

@property (weak, nonatomic) UIImageView *selectedBgView;

@property (nonatomic, weak) UIImageView *bgView;

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
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        

 
    }
    return self;
}

+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SettingCell";
    
    CJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (void)setItem:(CJSettingItem *)item
{
    // 1.设置数据
    _item = item;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    self.imageView.image = [UIImage imageNamed:item.icon];
    
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
        self.accessoryView = self.labelView;
    } else {
        self.accessoryView = nil;
    }
    
}



@end
