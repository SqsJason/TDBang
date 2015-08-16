//
//  HomeNewLoadView.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/20.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "HomeNewLoadView.h"

static const float image_Heght = 26;

@interface HomeNewLoadView ()
{
    UIImageView             *imgProduct;
    UIActivityIndicatorView *imgLoad;
    UILabel                 *lblTitle;
}
@end

@implementation HomeNewLoadView
@synthesize strImage,strName;

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    if(imgLoad)
    {
        [imgLoad stopAnimating];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(30, (frame.size.height - image_Heght) / 2, image_Heght, image_Heght)];
        imgProduct.image = [UIImage imageNamed:@"noimage"];
        [self addSubview:imgProduct];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, (frame.size.height - 20) / 2, 100, 20)];
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:lblTitle];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(NSString *)imgName title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(30, (frame.size.height - image_Heght) / 2, image_Heght, image_Heght)];
        imgProduct.image = [UIImage imageNamed:imgName];
        [self addSubview:imgProduct];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(75, (frame.size.height - 20) / 2, 100, 20)];
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.font = [UIFont systemFontOfSize:16.0];
        lblTitle.text = title;
        [self addSubview:lblTitle];
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return self;
}


@end
