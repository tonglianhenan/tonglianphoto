//
//  UICheckBoxButton.m
//  TongLian
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "UICheckBoxButton.h"

@implementation UICheckBoxButton
@synthesize label,icon,delegate;
- (id)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame: frame])
        {
            icon =[[UIImageView alloc] initWithFrame: CGRectMake (0, 0, frame.size.height, frame.size.height)];
            [self setChecked:NO];
            [self addSubview: icon];
            label =[[UILabel alloc] initWithFrame: CGRectMake(icon.frame.size.width + 7, 0,
                                                                frame.size.width - icon.frame.size.width - 10,
                                                                frame.size.height)];
            label.backgroundColor =[UIColor clearColor];
            label.textAlignment = NSTextAlignmentLeft;
            [self addSubview:label];
            [self addTarget:self action:@selector(clicked) forControlEvents: UIControlEventTouchUpInside];
        }
    return self;
}
-(BOOL)isChecked {
    return checked;
}

-(void)setChecked: (BOOL)flag {
    if (flag != checked)
    {
        checked = flag;
    }
    if (checked)
    {
        [icon setImage: [UIImage imageNamed:@"checkbox_selected.png"]];
    }
    else
    {
        [icon setImage: [UIImage imageNamed:@"checkbox_unselect.png"]];
    }
    
}
-(void)clicked {
    [self setChecked: !checked];
    if (delegate != nil)
    {
        SEL sel = NSSelectorFromString (@"checkButtonClicked");
        if ([delegate respondsToSelector: sel])
        {
            [delegate performSelector: sel];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
