//
//  CJStatusCacheTool.m
//  WeiBo
//
//  Created by mac527 on 15/10/4.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJStatusCacheTool.h"
#import "CJHomeStatusesParam.h"
#import "CJAccountTool.h"
#import "CJAccount.h"
#import "FMDB.h"
@implementation CJStatusCacheTool

static FMDatabaseQueue *_queue;

+ (void)initialize
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_statuses (id integer primary key autoincrement, idstr text, access_token text, dict blob);"];
    }];
}


+ (void)addStatusesWithArray:(NSArray *)array
{
    for (NSDictionary *dict in array) {
        [CJStatusCacheTool addStatusWithDict:dict];
    }

}


+ (void)addStatusWithDict:(NSDictionary *)dict
{
    NSString *idstr = dict[@"idstr"];
    NSString *access_token = [CJAccountTool account].access_token;
    NSData *dataDict = [NSKeyedArchiver archivedDataWithRootObject:dict];

    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_statuses (idstr, access_token, dict) values(?, ?, ?);",idstr,access_token,dataDict];
    }];

}

+ (NSArray *)statuesWithParam:(CJHomeStatusesParam *)param
{
    
    __block NSMutableArray *dictArray = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        
        dictArray = [NSMutableArray array];
        
        NSString *access_token = [CJAccountTool account].access_token;
        
        FMResultSet *result = nil;
        
        if (param.since_id) {
            result = [db executeQuery:@"select dict from t_statuses where access_token = ? and idstr >? order by idstr desc limit 0,?",access_token,param.since_id,param.count];
        }else if (param.max_id){
            result = [db executeQuery:@"select dict from t_statuses where access_token = ? and idstr <=? order by idstr desc limit 0,?",access_token,param.max_id,param.count];
        }else{
            result = [db executeQuery:@"select dict from t_statuses where access_token = ? order by idstr desc limit 0,?",access_token,param.count];
        }
        
        while (result.next) {
            NSData *data = [result dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dictArray addObject:dict];
        }
        
    }];
    return dictArray;
}

@end
