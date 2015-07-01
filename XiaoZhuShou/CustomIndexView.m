//
//  CustomIndexView.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-3.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CustomIndexView.h"

@implementation CustomIndexView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(540, 46);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        // 圆角UIView
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        self.backgroundView.layer.cornerRadius = 10.0;
        [self.scrollView addSubview:self.backgroundView];
        
        self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 46)];
        self.titleLabel.font=[UIFont fontWithName:@"STHeitiSC-Light" size:16];
        [self.backgroundView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 200, 46)];
        self.subTitleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        [self.backgroundView addSubview:self.subTitleLabel];
        self.subTitleLabel.backgroundColor = [UIColor clearColor];
        
//        UIFont *font=[UIFont systemFontOfSize:16];
//        CGSize size = [self.titleLabel.text sizeWithFont:font constrainedToSize:CGSizeMake(320,46) lineBreakMode:NSLineBreakByWordWrapping];
//        CGRect newFrame = self.titleLabel.frame;
//        newFrame.size.height = size.height;
//        self.titleLabel.frame = newFrame;
//        [self.titleLabel sizeToFit];
//        
//        CGRect rect=self.subTitleLabel.frame;
//        rect.origin.x=self.titleLabel.frame.origin.x+self.titleLabel.frame.size.width+10;
//        self.subTitleLabel.frame=rect;
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 0, 85, 46)];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.backgroundView addSubview:self.timeLabel];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(360, 5, 60, 36);
        [self.deleteBtn setTitle:@"删除"forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:19];
        
        [self.deleteBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn.tag = 0;
        [self.scrollView addSubview:self.deleteBtn];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.frame = CGRectMake(460, 5, 60, 36);
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:19];
        self.cancelBtn.tag = 1;
        [self.scrollView addSubview:self.cancelBtn];
        
        [self addSubview:self.scrollView];
        
        // 单击响应
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)btnDown:(UIButton *)btn
{
    if (btn.tag){
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        if ([self.delegate respondsToSelector:@selector(noteDidDelete:)]){
            [self.delegate noteDidDelete:self];
        }
        [self removeFromSuperview];
    }
}

- (void)tapSelector
{
    [self.delegate noteDidSelect:self];
}

@end
