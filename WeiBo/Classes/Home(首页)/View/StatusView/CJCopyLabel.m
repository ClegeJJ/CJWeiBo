//
//  CJCopyLabel.m
//  自定义可复制Label
//
//  Created by mac527 on 15/10/23.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJCopyLabel.h"

@implementation CJCopyLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attahTapHandler];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self attahTapHandler];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    [self attahTapHandler];
}

- (void)didMoveToSuperview
{
    NSLog(@"didMoveToSuperview");
}

- (void)attahTapHandler
{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:longPress];
    [self becomeFirstResponder];
}
- (void)handleTap:(UIGestureRecognizer *)tapGestureRecognizer
{

    self.backgroundColor = [UIColor blueColor];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}


- (BOOL)canBecomeFirstResponder{return YES;}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}


@end
