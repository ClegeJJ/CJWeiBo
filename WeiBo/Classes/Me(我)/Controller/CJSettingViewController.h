//
//  CJSettingViewController.h
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CJSettingGroup;
@interface CJSettingViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *groups;

- (CJSettingGroup *)addGroup;

@end
