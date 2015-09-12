//
//  CJAccountTool.m
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJAccountTool.h"


#import "CJAccount.h"


#define CJFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]    // 取出授权文件路径 再拼接文件路径


@implementation CJAccountTool

+ (CJAccount *)account
{

    CJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CJFilePath];
    NSDate *now = [NSDate date];

    if ([now compare:account.expires_time] == NSOrderedAscending) {  // 升序 右边的秒数大 没过期
        return account;
    }else { // 现在的时间大 过期了
        return nil;
    }

}

+ (void)saveAccount:(CJAccount *)account
{
    // 存储授权信息
    NSDate *now = [NSDate date];
    
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in];
    CJLog(@"%@",account.expires_time);
    
    [NSKeyedArchiver archiveRootObject:account toFile:CJFilePath];
    
}

@end
