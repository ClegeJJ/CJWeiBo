//
//  CJComposeToolBar.h
//  WeiBo
//
//  Created by mac527 on 15/9/18.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮类型枚举
 */
typedef enum{
    
    CJComposeToolBarButtonTypeCamera,
    CJComposeToolBarButtonTypePhotoLibrary,
    CJComposeToolBarButtonTypeMention,
    CJComposeToolBarButtonTypeTrend,
    CJComposeToolBarButtonTypeEmotion

} CJComposeToolBarButtonType;
@class CJComposeToolBar;

@protocol CJComposeToolBarDelegate <NSObject>

@optional

- (void)composeToolBar:(CJComposeToolBar *)toolBar didClickButton:(CJComposeToolBarButtonType)type;

@end

@interface CJComposeToolBar : UIView

- (void)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage tag:(CJComposeToolBarButtonType)type;

@property (nonatomic ,weak) id<CJComposeToolBarDelegate> delegate;

@end
