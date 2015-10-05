//
//  CJMeViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJMeViewController.h"
#import "CJSettingGroup.h"
#import "CJSettingArrowItem.h"
#import "CJSettingSwitchItem.h"
#import "CJSettingLabelItem.h"
#import "CJSystemSettingViewController.h"

@interface CJMeViewController ()

@end

@implementation CJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    

}

- (void)setupGroup0
{
    CJSettingGroup *group = [self addGroup];
    CJSettingArrowItem *newFriend = [CJSettingArrowItem itemWithIcon:@"new_friend" title:@"我的好友" destVcClass:nil];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    CJSettingGroup *group = [self addGroup];

    
    CJSettingArrowItem *album = [CJSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    CJSettingArrowItem *collect = [CJSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    CJSettingArrowItem *like = [CJSettingArrowItem itemWithIcon:@"like" title:@"我的赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *pay = [CJSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    CJSettingArrowItem *vip = [CJSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *card = [CJSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    CJSettingArrowItem *draft = [CJSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

- (void)setting
{
    CJSystemSettingViewController *sys = [[CJSystemSettingViewController alloc] init];
    
    [self.navigationController pushViewController:sys animated:YES];
}


@end
