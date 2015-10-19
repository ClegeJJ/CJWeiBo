//
//  CJFarmData.m
//  WeiBo
//
//  Created by mac527 on 15/9/19.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJFarmData.h"

@implementation CJFarmData
- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType
{
    self = [super init];
    if (self) {
        _data = data;
        _name = name;
        _fileName = fileName;
        _mimeType = mimeType;
    }
    return self;
}
@end
