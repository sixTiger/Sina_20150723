//
//  XXBStatus.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBStatus.h"
#import "XXBPhoto.h"
#import "NSDate+XXB.h"
#import "MJExtension.h"

@implementation XXBStatus

MJCodingImplementation;

// 把数组里面的字典转换成模型: value:模型类
- (NSDictionary *)objectClassInArray
{
    // key->数组的变量名,告诉哪个数组里面的字典需要转换成模型
    // value->字典需要转换成哪个模型
    // 把pic_urls这个数组里面的所有字典转换成模型
    return @{@"pic_urls":[XXBPhoto class]};
}

- (NSString *)created_at
{
    // 日期格式对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    // 设置日期的区域,只有告诉了区域,才能解析这个格式
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    // 获取创建的日期对象
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是不是今年
    if ([createDate isThisYear])
    { // 今年
        
        // 判断是否是今天
        if ([createDate isToday])
        { // 今天
            
            // 获取日期组件(微博创建的时间与当前时间的小时,分钟,秒差)
            NSDateComponents *component = [createDate deltaWithNow];
            // 获取小时差 当前16:00 微博创建的时间:14:00 component.hour = 2
            
            // 获取分钟差 当前16:17:12 微博创建的时间:14:17:00 minute = 6 不是126
            
            if (component.hour >= 1)
            { // 大于1小时小于24小时
                return [NSString stringWithFormat:@"%ld小时前",component.hour];
            }
            else
                if (component.minute > 1)
                { // 肯定小于1小时,大于1分钟
                    return [NSString stringWithFormat:@"%ld分钟前",component.minute];
                }
                else
                { // 小于1分钟
                    return @"刚刚";
                }
            
            
        }
        else
            if ([createDate isYesterday])
            { // 昨天
                fmt.dateFormat = @"昨天 HH:mm";
                
                return [fmt stringFromDate:createDate];
            }
            else
            { // 前天
                fmt.dateFormat = @"MM-dd HH:mm";
                return [fmt stringFromDate:createDate];
            }      
    }
    else
    { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return  [fmt stringFromDate:createDate];
    }
    
    // @"刚刚" 2分钟
}

- (void)setSource:(NSString *)source
{
    if (source.length)
    {
        //source 有值得时候才截取来源
        NSRange range = [source rangeOfString:@">"];
        // from包含index
        if (range.length)
        {
            
            source = [source substringFromIndex:range.location + 1];
            range = [source rangeOfString:@"<"];
            // to不包含index
            source = [source substringToIndex:range.location];
            _source = [NSString stringWithFormat:@"来自%@",source];
        }
        else
        {
            _source = [source copy];
        }
    }
    
}
@end
