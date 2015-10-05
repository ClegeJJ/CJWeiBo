//
//  CJSettingTableViewCell.h
//  WeiBo
//
//  Created by mac527 on 15/10/5.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJSettingItem;
@interface CJSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) CJSettingItem *item;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView;


@end
