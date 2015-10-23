//
//  CJDetailViewController.m
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailViewController.h"
#import "CJStatusFrame.h"
#import "CJStatus.h"
#import "CJStatusTopView.h"
#import "CJDetailCell.h"
#import "CJDetailCommentTool.h"
#import "CJStatusDetailBottomToolBar.h"
#import "CJStatusToolBar.h"
@interface CJDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) CJStatusToolBar *bottomBar;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSArray *statusGroup;
@property (nonatomic, strong) NSMutableArray *commentGroup;
@end

@implementation CJDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    
    [self setUpTableView];

    [self setUpBottomToolBar];
    
    [self setUpCommentsData];
    
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (NSArray *)statusGroup
{
    if (_statusGroup == nil) {
        CJStatusFrame *statusF = [[CJStatusFrame alloc] init];
        statusF.status = self.status;
        _statusGroup = @[statusF];
    }
    return _statusGroup;
}
- (NSMutableArray *)commentGroup
{
    if (_commentGroup == nil) {
        _commentGroup = [NSMutableArray array];
    }
    return _commentGroup;
}

- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 49) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CJGlobelBackgroundColor;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self.groups addObject:self.statusGroup];
}

- (void)setUpBottomToolBar
{
    CJStatusToolBar *bottomBar = [[CJStatusToolBar alloc] init];
    bottomBar.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.width, self.view.height - self.tableView.height);
    [self.view addSubview:bottomBar];
    self.bottomBar = bottomBar;
}

- (void)setUpCommentsData
{
    CJDetailCommentParam *param = [CJDetailCommentParam parma];
    param.ID = [NSNumber numberWithLongLong:[self.status.idstr longLongValue]];
    [CJDetailCommentTool detailCommentWithParam:param success:^(CJDetailCommentResult *result) {
        NSLog(@"成功");
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}


#pragma mark - tableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.groups.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *group = self.groups[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CJDetailCell *cell = [CJDetailCell cellWithTableView:tableView];
    
    NSArray *group = self.groups[indexPath.section];
    
    cell.statusFrame = group[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *group = self.groups[indexPath.section];
    
    CJStatusFrame *statusFrame = group[indexPath.row];
    
    return statusFrame.topViewF.size.height;
    
}
@end
