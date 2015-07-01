//
//  CustomIndexView.h
//  XiaoZhuShou
//
//  Created by yrq on 15-4-3.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol CustomIndexDelegate;

@interface CustomIndexView : UIView<UIScrollViewDelegate>
@property (assign)id<CustomIndexDelegate>delegate;
@property  int ID;
@property  int ID2;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIView *backgroundView;
@end

@protocol CustomIndexDelegate <NSObject>
- (void)noteDidDelete:(CustomIndexView *)note;
- (void)noteDidSelect:(CustomIndexView *)note;
@end