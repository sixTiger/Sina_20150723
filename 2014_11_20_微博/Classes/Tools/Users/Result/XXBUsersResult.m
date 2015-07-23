//
//  XXBUsersResult.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBUsersResult.h"

@implementation XXBUsersResult

/**
 *  所有消息界面未读数
 *
 */
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

/**
 *  所有的未读数
 *
 */
- (int)totalCount
{
    return self.messageCount + _status + _follower;;
}

@end
