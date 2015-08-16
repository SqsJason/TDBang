//
//  HomeNewIngOrEndView.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/23.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "HomeNewIngOrEndView.h"
#import "HomeNewedView.h"
#import "HomeNewingView.h"
#import "HomeNewLoadView.h"

@interface HomeNewIngOrEndView ()<HomeNewingViewDelegate,HomeNewedViewDelegate>
{
    __weak id<HomeNewIngOrEndViewDelegate> delegate;
    HomeNewedView       *viewEd;
    HomeNewingView      *viewIng;
    HomeNewLoadView     *viewLoading;
}
@end

@implementation HomeNewIngOrEndView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
    }
    return self;
}

- (void)setButtonImage:(NSString *)imgName Title:(NSString *)title
{
    CGRect frame = self.frame;
    viewLoading = [[HomeNewLoadView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) image:imgName title:title];
    [self addSubview:viewLoading];
}

- (void)setNewLoad
{
    [viewEd setHidden:YES];
    [viewIng setHidden:YES];
    [viewLoading setHidden:NO];
}

- (void)setNewing:(HomeNewing*)newing
{
    [viewEd setHidden:YES];
    [viewLoading setHidden:YES];
    [viewIng setHidden:NO];
    if (newing)
        [viewIng setNewing:newing];
}

- (void)setNewed:(HomeNewed*)newed
{
    [viewEd setHidden:NO];
    [viewLoading setHidden:YES];
    [viewIng setHidden:YES];
    if (newed)
        [viewEd setNewed:newed];
}

#pragma mark - delegate
- (void)doClickGoods:(int)goodsId codeId:(int)codeId
{
    if(delegate)
    {
        [delegate doClickGoods:goodsId codeId:codeId];
    }
}

@end
