//
//  XXBTextView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-29.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBTextView.h"


@interface XXBTextView ()
@property (nonatomic, weak) UILabel *placeHolderLabel;
@end

@implementation XXBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.font = self.font;
        [self addSubview:label];
        _placeHolderLabel = label;
        
    }
    return _placeHolderLabel;
}

/**
 *  设置字体
 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}
- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)setPlaceholder:(NSString *)placeholder
{
#warning 自己随便设置的距离 5 8
    _placeholder  = [placeholder copy];
    self.placeHolderLabel.text = placeholder;
    // 计算尺寸
    [self.placeHolderLabel sizeToFit];
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}
@end
