//
//  HomeNewLoadView.h
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/20.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNewLoadView : UIView

@property (nonatomic, strong) NSString *strImage;
@property (nonatomic, strong) NSString *strName;
- (id)initWithFrame:(CGRect)frame image:(NSString *)imgName title:(NSString *)title;

@end
