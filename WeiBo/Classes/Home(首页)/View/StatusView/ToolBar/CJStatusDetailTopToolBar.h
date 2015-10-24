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
    
    CJStatusDetailTopToolBarButtonTypeReposts,
    CJStatusDetailTopToolBarButtonTypeComment,
    CJStatusDetailTopToolBarButtonTypeAttitude
    
} CJStatusDetailTopToolBarButtonType;

@class CJStatusDetailTopToolBar;

@protocol CJStatusDetailTopToolBarDelegate <NSObject>

@optional

- (void)statusDetailTopToolBar:(CJStatusDetailTopToolBar *)toolBar didClickButton:(CJStatusDetailTopToolBarButtonType)type;

@end
@interface CJStatusDetailTopToolBar : UIView
@property (nonatomic, weak) id <CJStatusDetailTopToolBarDelegate> delegate;
@end
