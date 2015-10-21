//
//  CJDetailCell.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJStatusFrame;
@interface CJDetailCell : UITableViewCell
@property (nonatomic, strong) CJStatusFrame *statusFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
