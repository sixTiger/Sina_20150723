//
//  XXBStatusParam.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBStatusParam : NSObject

/**
 *  若指定此参数，则返回ID比since_id大的微博
 */
@property (nonatomic, strong) id since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博
 */
@property (nonatomic, strong) id max_id;
/**
 *  采用OAuth授权方式为必填参数
 */
@property (nonatomic, strong) id access_token;

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, strong) NSNumber *count;

@end
