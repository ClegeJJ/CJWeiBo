//
//  CJTextView.h
//  WeiBo
//
//  Created by mac527 on 15/9/17.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  发微博的文字框

#import <UIKit/UIKit.h>
@class CJTextView;
@protocol CJTextViewDelegate <NSObject>

@optional

- (void)textViewAttributedTextDidChange:(CJTextView *)textView;

@end

@interface CJTextView : UITextView
// 占位文字
@property (nonatomic ,copy) NSString *placeholder;

@property (weak, nonatomic) id <CJTextViewDelegate> CJdelegate;

@end
