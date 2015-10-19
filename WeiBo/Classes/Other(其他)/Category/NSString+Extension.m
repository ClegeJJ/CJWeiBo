//
//  NSString+Extension.m
//  WeiBo
//
//  Created by mac527 on 15/10/18.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)fileSize
{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (!exists) { // 路径不存在
        return @"0M";
    }
    if (dir) { // 文件夹
        //     计算缓存文件夹的大小
        NSArray *subpaths = [mgr subpathsAtPath:self];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
            if (dir == NO) {// 文件
                totalSize += [[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize] longLongValue];
            }
        }
        CGFloat sum = totalSize/1000/1000.0;
        if (sum < 0.1) {
            return @"0M";
        }else{
            return [NSString stringWithFormat:@"%.1fM",sum];
        }
        
    } else{ // 文件
        return [mgr attributesOfItemAtPath:self error:nil][NSFileSize];
    }
        

}
@end
