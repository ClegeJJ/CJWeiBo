//
//  CJConst.m
//  WeiBo
//
//  Created by mac527 on 15/10/5.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJConst.h"
// 1.授权信息
NSString * const AppKey = @"3087428443";
NSString * const AppSecret = @"cb2c460dcf79e93e80d4a8f396ee4013";
NSString * const AppRedirectURL = @"http://www.baidu.com";


// 2.通知
// 参数名
NSString * const CJselectedEmotionKey = @"selectedEmotionKey";
NSString * const CJShowPhotoBrowserKey = @"ShowPhotoBrowserKey";
NSString * const CJPhotoIndexKey = @"photoIndexKey";
NSString * const CJDidTapSpecialTextKey = @"didTapSpecialTextKey";
// 通知名
NSString * const CJEmotionKeyboardDidSelectedNotification = @"emotionKeyboardDidSelectedNotification";
NSString * const CJPhotoDidTapNotification = @"photoDidTapNotification";

NSString * const CJDidTapSpecialTextNotification = @"didTapSpecialTextNotification";

// 删除按钮点击通知
NSString * const CJEmitionkeyboardDidDeletedNotification = @"deletedNotification";