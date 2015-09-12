//
//  CJAccount.h
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, assign) long long expires_in;

@property (nonatomic, assign) long long remind_in;

@property (nonatomic, assign) long long uid;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
/*
 "access_token" = "2.00Y_6cNGxKXw3D69bcff011apQoH7E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5698043136;

*/