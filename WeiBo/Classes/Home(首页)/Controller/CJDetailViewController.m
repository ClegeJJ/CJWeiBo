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
#import "CJStatusDetailTopToolBar.h"
@interface CJDetailViewController () <UITableViewDelegate,UITableViewDataSource,CJStatusDetailTopToolBarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) CJStatusDetailTopToolBar *topToolBar;

@end

@implementation CJDetailViewController
- (NSMutableArray *)comments
{
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    [self setUpTableView];

    [self setupDetailView];
    
    [self setUpBottomToolBar];
    
    [self setUpTopToolBar];
    
//    [self setUpCommentsData];
}

/**
 *  创建微博详情控件
 */
- (void)setupDetailView
{
    // 创建微博详情控件
    CJStatusTopView *topStatusView = [[CJStatusTopView alloc] init];
    // 创建frame对象
    CJStatusFrame *topStatusFrame = [[CJStatusFrame alloc] init];
    topStatusFrame.status = self.status;
    // 传递frame数据
    topStatusView.statusFrame = topStatusFrame;
    // 设置微博详情的高度
    topStatusView.height = topStatusFrame.topViewF.size.height;
    topStatusView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = topStatusView;
}


/**
 *  初始化tableView
 */
- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 49)];
    [self.view addSubview:tableView];

    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CJGlobelBackgroundColor;
}

- (void)setUpBottomToolBar
{
    CJStatusDetailBottomToolBar *bottomBar = [[CJStatusDetailBottomToolBar alloc] init];
    bottomBar.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.width, self.view.height - self.tableView.height);
    [self.view addSubview:bottomBar];
}
- (void)setUpTopToolBar
{
    self.topToolBar = [[CJStatusDetailTopToolBar alloc] init];
    self.topToolBar.delegate = self;
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



#pragma mark - CJStatusDetailTopToolBar代理方法
- (void)statusDetailTopToolBar:(CJStatusDetailTopToolBar *)toolBar didClickButton:(CJStatusDetailTopToolBarButtonType)type
{
    switch (type) {
        case CJStatusDetailTopToolBarButtonTypeReposts:
            [self loadReposts];
            break;
        case CJStatusDetailTopToolBarButtonTypeComment:
            [self loadCommentData];
            break;
        case CJStatusDetailTopToolBarButtonTypeAttitude:
            NSLog(@"Attitude");
    }
}

- (void)loadReposts
{
    NSLog(@"Reposts");
}
- (void)loadCommentData
{
    NSLog(@"Comment");
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"contacts";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"text--%ld",indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

@end
