//
//  DateSwitchView.m
//  zwy
//
//  Created by cqsxit on 13-11-19.
//  Copyright (c) 2013年 sxit. All rights reserved.
//

#import "DateSwitchView.h"

@implementation DateSwitchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (_UISwitchSlider *) slider {
    return [[self subviews] lastObject];
}
- (UIView *) textHolder {
    return [[[self slider] subviews] objectAtIndex:2];
}
- (UILabel *) leftLabel {
    return [[[self textHolder] subviews] objectAtIndex:0];
}
- (UILabel *) rightLabel {
    return [[[self textHolder] subviews] objectAtIndex:1];
}
// 创建文本标签
- (UILabel*) createLabelWithText:(NSString*)labelText
                            font:(UIFont*)labelFont
                           color:(UIColor*)labelColor
{
    CGRect rect = CGRectMake(-25.0f, -10.0f, 50.0f, 20.0f);
    UILabel *label = [[UILabel alloc] initWithFrame: rect];
    label.text = labelText;
    label.font = labelFont;
    label.textColor = labelColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

// 重新设定左边的文本标签
- (void) setLeftLabelText:(NSString *)labelText
                     font:(UIFont*)labelFont
                    color:(UIColor *)labelColor
{
    @try {
        //
        [[self leftLabel] setText:labelText];
        [[self leftLabel] setFont:labelFont];
        [[self leftLabel] setTextColor:labelColor];
    } @catch (NSException *ex) {
        //
        UIImageView* leftImage = (UIImageView*)[self leftLabel];
        leftImage.image = nil;
        leftImage.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
        
        //
        [leftImage addSubview: [self createLabelWithText:labelText
                                                     font:labelFont
                                                    color:labelColor]];
    }
}

// 重新设定右边的文本
- (void) setRightLabelText:(NSString *)labelText font:(UIFont*)labelFont color:(UIColor *)labelColor {
    @try {
        //
        [[self rightLabel] setText:labelText];
        [[self rightLabel] setFont:labelFont];
        [[self rightLabel] setTextColor:labelColor];
    } @catch (NSException *ex) {
        //
        UIImageView* rightImage = (UIImageView*)[self rightLabel];
        rightImage.image = nil;
        rightImage.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
        
        //
        [rightImage addSubview: [self createLabelWithText:labelText
                                                      font:labelFont
                                                     color:labelColor]];
    }
}

@end
