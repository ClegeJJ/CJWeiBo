//
//  CJAccount.m
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJAccount.h"

@implementation CJAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;

}


+ (instancetype)accountWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];


}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];

    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}
@end
