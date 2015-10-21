//
//  CJDetailCell.m
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJDetailCell.h"
#import "CJStatusTopView.h"
#import "CJStatusFrame.h"
@interface CJDetailCell()
/**
 *  顶部的View(原微博父控件)
 */
@property (nonatomic, weak) CJStatusTopView *topView;


@end

@implementation CJDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Home_Cell";
    
    CJDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[CJDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    return cell;
    
}


#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1.添加顶部微博视图
        [self setupTopViewSubviews];
        
        // 2.添加底部的工具条
//        [self setupStatusToolBar];
        
        // 3.设置cell被选中时的背景
//        UIView *bgView = [[UIView alloc] init];
//        bgView.backgroundColor = CJColor(240, 240, 240);
//        self.selectedBackgroundView = bgView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/**
 *  添加顶部微博视图
 */
- (void)setupTopViewSubviews
{
    /** 顶部的View(原微博父控件) */
    CJStatusTopView *topView = [[CJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}
- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    
    _statusFrame = statusFrame;
    // 1.设置顶部微博视图数据
    [self setupTopViewData];
    
    // 2.设置底部工具条视图数据
//    [self setupStatusToolBarData];
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
@end
