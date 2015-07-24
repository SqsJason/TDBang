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
        self.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
        UIImageView *imvBG = [[UIImageView alloc] initWithFrame:self.frame];
        imvBG.image = [UIImage imageNamed:@"mine_headview_bg"];
        imvBG.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:imvBG];
        
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
        
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(headPadding_L + imvHead.frame.size.width + userHeadPadding_Right, 60, 90, 40)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [btn setTitle:@"马上登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
        [btn addTarget:self action:@selector(btnLoginAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        CGFloat width = (mainWidth - 1)/2;
        CGFloat height = 30;
        CGFloat perW = 0;
        
        UIButton *btnNew = [[UIButton alloc] initWithFrame:CGRectMake(perW, userHeadPadding_Top + 20 + imvHead.frame.size.height, width, height)];
        btnNew.backgroundColor = [UIColor blackColor];
        btnNew.alpha = 0.4;
        [btnNew addTarget:self action:@selector(newAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnNew];
        
        UILabel *lblNew = [[UILabel alloc] init];
        lblNew.text = @"我的余额: 1000.00";
        lblNew.font = [UIFont systemFontOfSize:14];
        lblNew.textColor = [UIColor whiteColor];
        lblNew.textAlignment = NSTextAlignmentCenter;
        lblNew.frame = CGRectMake(perW, btnNew.frame.origin.y, width, height);
                [self addSubview:lblNew];
        
        UIButton * btnShow = [[UIButton alloc] initWithFrame:CGRectMake(perW * 2 + width + 1, btnNew.frame.origin.y, width, height)];
        btnShow.backgroundColor = [UIColor blackColor];
        btnShow.alpha = 0.4;
        [btnShow addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnShow];
        
        UILabel *lblShow = [[UILabel alloc] init];
        lblShow.text = @"我的积分: 10000";
        lblShow.font = [UIFont systemFontOfSize:14];
        lblShow.textColor = [UIColor whiteColor];
        lblShow.frame = CGRectMake(btnShow.frame.origin.x, btnNew.frame.origin.y, width, height);
        lblShow.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lblShow];
    }
    return self;
}

- (void)btnLoginAction
{
    [delegate doLogin];
}

- (void)newAction
{
    if(delegate)
    {
        
    }
}

- (void)showAction
{
    if(delegate)
    {
        
    }
}

@end
