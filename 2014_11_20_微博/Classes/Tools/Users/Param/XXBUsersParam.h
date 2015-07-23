//
//  XXBUsersParam.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	false	int64	需要查询的用户ID。
 */

@interface XXBUsersParam : NSObject

/**
 *  需要查询的用户ID
 */
@property (nonatomic, strong) id uid;
/**
 *  采用OAuth授权方式为必填参数
 */
@property (nonatomic, strong) id access_token;

@end
