//
//  XXBBadgeValue.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBBadgeValue.h"

/**
 *  注意，左右会有一个像素的偏差，右边的需要比左边的少2
 */
#define marginLeft 7
#define marginRight 5

@implementation XXBBadgeValue

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.hidden = YES;
    self.userInteractionEnabled = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    /**
     *  微调文字的位置
     */
    self.titleEdgeInsets = UIEdgeInsetsMake(0, marginLeft, 0, marginRight) ;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if (badgeValue && badgeValue.intValue >0)
    {
        /**
         *  有值并且值不等于1 的情况向才进行相关设置
         */
        self.hidden = NO;
        
        if (badgeValue.length>2)
        {
            /**
             *  值大约99的画就显示一个小圆点
             */
            [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
            
            [self setBackgroundImage:nil forState:UIControlStateNormal];
            self.frame = CGRectMake(0, 0, 30, 20);
        }
        else
        {
            /**
             *  其他情况就设置为相应的数值
             */
            
            UIImage *bgImage = [UIImage imageNamed:@"main_badge"];
            
            /**
             *  设置提示按钮的背景图片
             */
            
            [self setBackgroundImage:[bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5] forState:UIControlStateNormal];
            [self setImage:nil forState:UIControlStateNormal];
            [self setTitle:badgeValue forState:UIControlStateNormal];
            // 根据文字的多少动态计算frame
            CGRect frame = self.frame;
            CGFloat badgeH = self.currentBackgroundImage.size.height;
            CGFloat badgeW ;
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSFontAttributeName] = self.titleLabel.font;
           
            CGSize badgeSize =  [self.badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
            badgeW = badgeSize.width + marginLeft +marginRight;
            frame.size.width = badgeW;
            frame.size.height = badgeH;
            self.frame = frame;
        }
    }
    else
    {
        /**
         *  其他情况直接隐藏
         */
        self.hidden = YES;
    }
}


@end
