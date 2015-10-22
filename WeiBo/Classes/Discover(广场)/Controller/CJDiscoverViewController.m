//
//  CJDiscoverViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/9.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDiscoverViewController.h"
#import "CJSettingGroup.h"
#import "CJSettingItem.h"
#import "CJSettingArrowItem.h"
#import "CJSettingLabelItem.h"
#import "CJSettingTableViewCell.h"
#import "CJSearchBar.h"
@interface CJDiscoverViewController ()

@end

@implementation CJDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置顶部搜索框
    CJSearchBar *searchbar = [[CJSearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.navigationItem.titleView = searchbar;

    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    CJSettingGroup *group = [CJSettingGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    
    CJSettingItem *hotStatus = [CJSettingItem itemWithIcon:@"hot_status" title:@"热门微博"];
    
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    CJSettingItem *findPeople = [CJSettingItem itemWithIcon:@"find_people" title:@"找人"];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    CJSettingGroup *group = [CJSettingGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CJSettingArrowItem *gameCenter = [CJSettingArrowItem itemWithIcon:@"game_center" title:@"游戏中心"];
    CJSettingLabelItem *near = [CJSettingLabelItem itemWithIcon:@"near" title:@"周边"];
    near.text = @"我是个二逼~";
    CJSettingItem *app = [CJSettingItem itemWithIcon:@"app" title:@"应用"];
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    CJSettingGroup *group = [CJSettingGroup group];
    [self.groups addObject:group];
    // 2.设置组的所有行数据
    CJSettingItem *video = [CJSettingItem itemWithIcon:@"video" title:@"视频"];
    CJSettingItem *music = [CJSettingItem itemWithIcon:@"music" title:@"音乐"];
    CJSettingItem *movie = [CJSettingItem itemWithIcon:@"movie" title:@"电影"];
    CJSettingItem *cast = [CJSettingItem itemWithIcon:@"cast" title:@"播客"];
    CJSettingItem *more = [CJSettingItem itemWithIcon:@"more" title:@"更多"];
    group.items = @[video, music, movie, cast, more];
}



@end
