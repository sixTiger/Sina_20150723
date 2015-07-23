//
//  XXBAccount.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBAccount.h"


#define XXBAccessToken @"access_token"
#define XXBUid @"uid"
#define XXBExpiresIn @"expires_in"
#define XXBExpiresDate @"expires_date"



@implementation XXBAccount



// 设置有效期,就算下过期时间
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 过期时间 = 当前时间 + 有效期
    NSDate *date = [NSDate date];
    // 在date这个时间上加上有效期
    _expires_date = [date dateByAddingTimeInterval:[expires_in longLongValue]];
}
// 告诉系统哪些属性需要归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:XXBAccessToken];
    [aCoder encodeObject:_uid forKey:XXBUid];
    [aCoder encodeObject:_expires_in forKey:XXBExpiresIn];
    [aCoder encodeObject:_expires_date forKey:XXBExpiresDate];
}

//  告诉系统哪些属性需要解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:XXBAccessToken];
        self.uid = [aDecoder decodeObjectForKey:XXBUid];
        self.expires_in = [aDecoder decodeObjectForKey:XXBExpiresIn];
        self.expires_date = [aDecoder decodeObjectForKey:XXBExpiresDate];
        
    }
    return self;
}
@end
