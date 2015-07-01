//
//  TipViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-5-14.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (retain, nonatomic) UIScrollView *pageScroll;
@property (retain, nonatomic) UIPageControl *pageControl;

- (void)gotoMainView:(id)sender;
@property (retain, nonatomic) UIButton *gotoMainViewBtn;
@end
