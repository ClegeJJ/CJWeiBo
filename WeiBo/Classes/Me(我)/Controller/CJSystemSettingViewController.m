//
//  CJSystemSettingViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "CJSystemSettingViewController.h"
#import "CJSettingArrowItem.h"
#import "CJSettingGroup.h"
#import "CJGeneralViewController.h"

@interface CJSystemSettingViewController ()

@end

@implementation CJSystemSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}

/**
 *  退出登录按钮~
 */
- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:CJColor(255, 20, 20) forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    logoutButton.height = 44;
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_card_middle_background"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_card_middle_background_highlighted"] forState:UIControlStateHighlighted];
    self.tableView.tableFooterView = logoutButton;
}

- (void)setupGroup0
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *account = [CJSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *theme = [CJSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *notice = [CJSettingArrowItem itemWithTitle:@"通知和提醒"];
    CJSettingArrowItem *general = [CJSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[CJGeneralViewController class]];
    CJSettingArrowItem *safe = [CJSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *opinion = [CJSettingArrowItem itemWithTitle:@"意见反馈"];
    CJSettingArrowItem *about = [CJSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}

@end