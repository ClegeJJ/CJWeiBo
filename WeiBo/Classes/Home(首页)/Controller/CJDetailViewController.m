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
@interface CJDetailViewController ()

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSArray *statusGroup;
@property (nonatomic, strong) NSMutableArray *commentGroup;
@end

@implementation CJDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self.groups addObject:self.statusGroup];

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
        _statusGroup = @[self.statusF];
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

- (void)setUpCommentsData
{
    CJDetailCommentParam *param = [CJDetailCommentParam parma];
    param.ID = [NSNumber numberWithLongLong:[self.statusF.status.idstr longLongValue]];
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
