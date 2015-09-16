//
//  CJStatusCell.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusCell.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "CJStatusToolBar.h"
#import "CJRetweetStatusView.h"
#import "CJStatusTopView.h"

@interface CJStatusCell()
/**
 *  顶部的View(原微博父控件)
 */
@property (nonatomic, weak) CJStatusTopView *topView;



/**
 *  微博的工具条(底部工具条父控件)
 */
@property (nonatomic, weak) CJStatusToolBar *statusTool;



@end

@implementation CJStatusCell

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Home_Cell";
    
    CJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[CJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;

}

#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.添加顶部微博视图
        [self setupTopViewSubviews];
        
        // 2.添加底部的工具条
        [self setupStatusToolBar];
        
        // 3.设置cell被选中时的背景
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = CJColor(240, 240, 240);
        self.selectedBackgroundView = bgView;
        
    }
    return self;
}
/**
 *   拦截tableViewCell的frame设置
 *
 *  @param frame
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= CJStatusFrameBorder;
    
    [super setFrame:frame];

}

/**
 *  添加顶部微博视图
 */
- (void)setupTopViewSubviews
{

    /** 设置cell被选中时的背景 */
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = CJColor(240, 240, 240);
    self.selectedBackgroundView = bgView;
    
    /** 顶部的View(原微博父控件) */
    CJStatusTopView *topView = [[CJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    

}
/**
 *  添加底部的工具条
 */
- (void)setupStatusToolBar
{
    /**  微博的工具条(底部工具条父控件)*/
    CJStatusToolBar *statusTool = [[CJStatusToolBar alloc] init];
    [self.contentView addSubview:statusTool];
    self.statusTool = statusTool;
}

#pragma mark - 赋值

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    // 1.设置顶部微博视图数据
    [self setupTopViewData];
    
    // 2.设置底部工具条视图数据
    [self setupStatusToolBarData];
}

/**
 *  设置顶部微博视图数据
 */
- (void)setupTopViewData
{
    /** 顶部的View(原微博父控件) */
    // 1.设置frame
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;

}


/**
 *  设置底部工具条视图数据
 */
- (void)setupStatusToolBarData
{
    // 1.设置frame
    self.statusTool.frame = self.statusFrame.statusToolF;
    
    // 2.传递模型数据
    self.statusTool.status = self.statusFrame.status;
    
}

@end
