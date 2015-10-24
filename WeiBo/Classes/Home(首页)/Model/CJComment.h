//
//  CJDetail.h
//  WeiBo
//
//  Created by mac527 on 15/10/21.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJUser,CJStatus;
@interface CJComment : NSObject
///**
// *  评论的发送时间
// */
//@property (nonatomic, copy) NSString *created_at;
///**
// *  评论的正文
// */
//@property (nonatomic, copy) NSString *text;
///**
// *  评论的作者
// */
//@property (nonatomic, strong) CJUser *user;
// {"name" : "jack", "age":10}
/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	评论作者的用户信息字段 详细*/
@property (nonatomic, strong) CJUser *user;

/** 	object	评论的微博信息字段 详细*/
@property (nonatomic, strong) CJStatus *status;
@end
