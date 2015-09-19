//
//  CJFarmData.h
//  WeiBo
//
//  Created by mac527 on 15/9/19.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  发送复杂Post请求的参数模型

#import <Foundation/Foundation.h>

@interface CJFarmData : NSObject

@property (nonatomic ,strong) NSData *data;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *fileName;

@property (nonatomic ,copy) NSString *mimeType;

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end

//        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];