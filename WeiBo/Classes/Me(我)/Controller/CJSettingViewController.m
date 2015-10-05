//
//  CJSettingViewController.m
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJSettingViewController.h"
#import "CJSettingGroup.h"
#import "CJSettingItem.h"
#import "CJSettingTableViewCell.h"
#import "CJSettingArrowItem.h"
@interface CJSettingViewController ()

@end

@implementation CJSettingViewController

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
    self.tableView.backgroundColor = CJColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);


}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (CJSettingGroup *)addGroup
{
    CJSettingGroup *group = [CJSettingGroup group];
    [self.groups addObject:group];
    return group;
}


#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.groups.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    CJSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CJSettingTableViewCell *cell = [CJSettingTableViewCell settingCellWithTableView:tableView];
    
    CJSettingGroup *settingGroup = self.groups[indexPath.section];

    cell.item = settingGroup.items[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CJSettingGroup *settingGroup = self.groups[indexPath.section];
    CJSettingItem *item = settingGroup.items[indexPath.row];
    
    if (item.opreation) {  // 有特定操作
        item.opreation();
    }
    if ([item isKindOfClass:[CJSettingArrowItem class]]) {
        CJSettingArrowItem *arrowItem = (CJSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *Vc = [[arrowItem.destVcClass alloc] init];
            Vc.title = arrowItem.title;
            [self.navigationController pushViewController:Vc animated:YES];
        }
    }
}



@end
