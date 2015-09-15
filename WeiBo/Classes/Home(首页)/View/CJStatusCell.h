//
//  CJStatusCell.h
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博首页自定义的 cell

#import <UIKit/UIKit.h>
@class CJStatusFrame;
@interface CJStatusCell : UITableViewCell

@property (nonatomic, strong) CJStatusFrame *statusFrame;


+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
