//
//  VersionDetailViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-5-2.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "VersionDetailViewController.h"

@interface VersionDetailViewController ()

@end

@implementation VersionDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:0.15 green:0.6 blue:0.88 alpha:1]];
    [self.view addSubview:topView];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(10, 0, 44, 44)];
    [back addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:back];
    
    
    self.versionNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
    self.versionNum.text=@"当前版本v1.0";
    self.versionNum.textAlignment=NSTextAlignmentCenter;
    self.versionNum.font=[UIFont boldSystemFontOfSize:16.0];
    
    self.versionTime=[[UILabel alloc]initWithFrame:CGRectMake(0, [self getY:self.versionNum], self.view.frame.size.width, 44)];
    self.versionTime.text=@"2015-5";
    self.versionTime.textAlignment=NSTextAlignmentCenter;
    self.versionTime.font=[UIFont boldSystemFontOfSize:16.0];

    self.introduction=[[UILabel alloc]initWithFrame:CGRectMake(10, [self getY:self.versionTime]+5, self.view.frame.size.width-20, 300)];
    self.introduction.text=@"      本应用作为一个手机的离线编程知识库，方便编程爱好者与程序员在编写代码或学习的过程中检索相应的语言知识。\n\n      献给热爱编程的朋友们以及正在学习准备成为程序开发者行业的朋友们的礼物。";
    self.introduction.font = [UIFont systemFontOfSize:14.0f];
    self.introduction.numberOfLines = 0;
    self.introduction.lineBreakMode = NSLineBreakByCharWrapping;
    [self.introduction sizeToFit];
    
    self.detail=[[UILabel alloc]initWithFrame:CGRectMake(10, [self getY:self.introduction]+10, self.view.frame.size.width-20, 300)];
    self.detail.text=@"      该版本为此应用的第一个版本，在该版本中更新了：\n      ● 八种常用语言的内容\n      ● 自定义语言与条目功能\n      ● 添加笔记/书签功能\n      ● 添加夜间模式\n      ● 添加笔记编辑框的相关动画效果";
    self.detail.font=[UIFont systemFontOfSize:14.0f];
    self.detail.numberOfLines=0;
    self.detail.lineBreakMode=NSLineBreakByCharWrapping;
    self.detail.textColor=[UIColor redColor];
    [self.detail sizeToFit];
    
    [self.view addSubview:self.versionNum];
    [self.view addSubview:self.versionTime];
    [self.view addSubview:self.introduction];
    [self.view addSubview:self.detail];
    [self.view addSubview:topView];
    
    
}

-(CGFloat)getY:(UIView*)view
{
    return view.frame.origin.y+view.frame.size.height;
}

-(void)backView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
