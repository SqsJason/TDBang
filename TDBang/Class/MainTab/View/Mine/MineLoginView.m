//
//  MineLoginView.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/23.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "MineLoginView.h"
#import "LoginVC.h"

const static float userHead_Size            = 70.0;
const static float userHeadPadding_Top      = 30.0;
const static float userHeadPadding_Right    = 30.0;

@interface MineLoginView ()
{
    __weak id<MineLoginViewDelegate> delegate;
}
@end

@implementation MineLoginView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imvHead = [[UIImageView alloc] init];
        imvHead.layer.cornerRadius = userHead_Size/2;
        imvHead.layer.masksToBounds = YES;
        imvHead.image = [UIImage imageNamed:@"kefu"];
        
        UILabel* lbl = [[UILabel alloc] init];
        lbl.text = @"您还没有登录哦~";
        lbl.textColor = [UIColor grayColor];
        lbl.font = [UIFont systemFontOfSize:16];
        CGSize s = [lbl.text textSizeWithFont:lbl.font constrainedToSize:CGSizeMake(MAXFLOAT, 999) lineBreakMode:NSLineBreakByCharWrapping];
        
        float headPadding_L = (mainWidth - s.width - userHead_Size - 2*userHeadPadding_Right)/2;
        imvHead.frame = CGRectMake(headPadding_L, userHeadPadding_Top, userHead_Size, userHead_Size);
        lbl.frame = CGRectMake(headPadding_L + imvHead.frame.size.width + userHeadPadding_Right, userHeadPadding_Top, s.width, s.height);
        
        [self addSubview:imvHead];
        [self addSubview:lbl];
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(headPadding_L + imvHead.frame.size.width + userHeadPadding_Right, 60, 150, 44)];
        [btn setTitle:@"马上登录" forState:UIControlStateNormal];
        [btn setTitleColor:mainColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
        [btn addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)btnLoginAction
{
    [delegate doLogin];
}
@end
