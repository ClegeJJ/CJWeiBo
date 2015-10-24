//
//  CJStatusDetailTopToolBar.h
//  WeiBo
//
//  Created by mac527 on 15/10/23.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  按钮类型枚举
 */
typedef enum{
    
    CJStatusDetailTopToolBarButtonTypeReposts, // 转发
    CJStatusDetailTopToolBarButtonTypeComment,  // 评论
    CJStatusDetailTopToolBarButtonTypeAttitude // 赞
    
} CJStatusDetailTopToolBarButtonType;

@class CJStatusDetailTopToolBar,CJStatus;

@protocol CJStatusDetailTopToolBarDelegate <NSObject>

@optional

- (void)statusDetailTopToolBar:(CJStatusDetailTopToolBar *)toolBar didClickButton:(CJStatusDetailTopToolBarButtonType)type;

@end
@interface CJStatusDetailTopToolBar : UIView

@property (nonatomic, strong) CJStatus *status;
@property (nonatomic, weak) id <CJStatusDetailTopToolBarDelegate> delegate;
/**
 *  被选中的按钮类型
 */
@property (nonatomic, assign) CJStatusDetailTopToolBarButtonType selectedButtonType;
@end
