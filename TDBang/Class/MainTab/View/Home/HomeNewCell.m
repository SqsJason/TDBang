//
//  HomeNewCell.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/19.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "HomeNewCell.h"
#import "HomeNewIngOrEndView.h"


@interface HomeNewCell ()<HomeNewIngOrEndViewDelegate>
{
    __weak id<HomeNewCellDelegate> delegate;
    HomeNewIngOrEndView *view1;
    HomeNewIngOrEndView *view2;
}

@end

@implementation HomeNewCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setHolderButtonImage_O:(NSString *)imgNameO
                       Title_O:(NSString *)titleO
                       Image_T:(NSString *)imgNameT
                       Title_T:(NSString *)titleT
                           tag:(NSInteger)aTag
{
    view1 = [[HomeNewIngOrEndView alloc] initWithFrame:CGRectMake(0, 0, mainWidth / 2, 60)];
    [view1 setButtonImage:imgNameO Title:titleO];
    view1.delegate = self;
    [self addSubview:view1];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mainWidth / 2, 60)];
    btn1.tag = aTag;
    [btn1 setTitle:@"" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 addTarget:self action:@selector(firstButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    
    view2 = [[HomeNewIngOrEndView alloc] initWithFrame:CGRectMake(mainWidth / 2, 0, mainWidth / 2, 60)];
    [view2 setButtonImage:imgNameT Title:titleT];
    view2.delegate = self;
    [self addSubview:view2];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(mainWidth / 2, 0, mainWidth / 2, 60)];
    btn2.tag = aTag;
    btn2.backgroundColor = [UIColor clearColor];
    [btn2 setTitle:@"" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
}

- (void)setNews:(HomeNewingList*)listNewing homepage:(NSArray*)listHomepage
{
    if(!listNewing)
    {
        [view1 setNewLoad];
        [view2 setNewLoad];
        return;
    }
    if (listNewing.listItems.count > 0)
    {
        for (int i = 0; i<listNewing.listItems.count;i++) {
            if(i == 0)
            {
                [view1 setNewing:[listNewing.listItems objectAtIndex:i]];
            }
            else if(i == 1)
            {
                [view2 setNewing:[listNewing.listItems objectAtIndex:i]];
            }
        }
    }
    int newCount = (int)listNewing.listItems.count;
    int leftCount = 4 - newCount;
    for(int i =0;i<leftCount;i++)
    {
        int location = newCount + i;
        if(location == 0)
        {
            [view1 setNewed:[listHomepage objectAtIndex:i]];
        }
        else if(location == 1)
        {
            [view2 setNewed:[listHomepage objectAtIndex:i]];
        }
    }
}

#pragma mark - delegate
- (void)doClickGoods:(int)goodsId codeId:(int)codeId
{
    if(delegate)
    {
        [delegate doClickGoods:goodsId codeId:codeId];
    }
}

- (void)firstButtonAction:(UIButton *)sender
{
    if(delegate && [delegate respondsToSelector:@selector(firstItemClicked:)])
    {
        [delegate firstItemClicked:sender];
    }
}

- (void)secondButtonAction:(UIButton *)sender
{
    if(delegate && [delegate respondsToSelector:@selector(secondItemClicked:)])
    {
        [delegate secondItemClicked:sender];
    }
}

@end
