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
#import "CJDetailTool.h"
#import "CJStatusDetailBottomToolBar.h"
#import "CJStatusToolBar.h"
#import "CJComment.h"
#import "CJStatusDetailTopToolBar.h"
@interface CJDetailViewController () <UITableViewDelegate,UITableViewDataSource,CJStatusDetailTopToolBarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) NSMutableArray *reposts;
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
- (NSMutableArray *)reposts
{
    if (_reposts == nil) {
        _reposts = [NSMutableArray array];
    }
    return _reposts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    [self setUpTableView];

    [self setupDetailView];
    
    [self setUpBottomToolBar];
    
    [self setUpTopToolBar];
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
    self.status.retweeted_status.detail = YES;
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
    self.topToolBar.status = self.status;
    self.topToolBar.delegate = self;
}

#pragma mark - CJStatusDetailTopToolBar代理方法
- (void)statusDetailTopToolBar:(CJStatusDetailTopToolBar *)toolBar didClickButton:(CJStatusDetailTopToolBarButtonType)type
{
    [self.tableView reloadData];
    
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
    CJDetailRepostParma *param = [CJDetailRepostParma parma];
    param.id = self.status.idstr;
    CJStatus *repost = [self.reposts firstObject];
    param.since_id = repost.idstr;
    
    [CJDetailTool detailRepostWithParam:param success:^(CJDetailRepostResult *result) {
        // 获取最新评论总数
        self.status.reposts_count = result.total_number;
        self.topToolBar.status = self.status;
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.reposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
     NSLog(@"loadReposts失败");
    }];
    
}

- (void)loadCommentData
{
    CJDetailCommentParam *param = [CJDetailCommentParam parma];
    CJComment *comment = [self.comments firstObject];
    param.id = self.status.idstr;
    param.since_id = comment.idstr;
    
    [CJDetailTool detailCommentWithParam:param success:^(CJDetailCommentResult *result) {
        // 获取最新评论总数
        self.status.comments_count = result.total_number;
        self.topToolBar.status = self.status;
        
        // 累加前面的评论
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        [self.comments insertObjects:result.comments atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"loadCommentData失败");
    }];
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topToolBar.selectedButtonType == CJStatusDetailTopToolBarButtonTypeComment) {
        return self.comments.count;
    } else if (self.topToolBar.selectedButtonType == CJStatusDetailTopToolBarButtonTypeReposts){
        return self.reposts.count;
//        return 10;
    } else {
        return 0;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"contacts";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    if (self.topToolBar.selectedButtonType == CJStatusDetailTopToolBarButtonTypeComment) {
        CJComment *cmt = self.comments[indexPath.row];
        cell.textLabel.text = cmt.text;
    }else if (self.topToolBar.selectedButtonType == CJStatusDetailTopToolBarButtonTypeReposts){
        CJStatus *status = self.reposts[indexPath.row];
//        cell.textLabel.text = @"特么的接口被屏蔽了";
        cell.textLabel.text = status.text;
    }
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
