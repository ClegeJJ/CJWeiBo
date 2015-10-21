//
//  CJDetailViewController.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  微博详情控制器

#import <UIKit/UIKit.h>
@class CJStatusFrame;
@interface CJDetailViewController : UITableViewController

/**
 *  微博模型
 */
@property (nonatomic, strong) CJStatusFrame *statusF;

@end
