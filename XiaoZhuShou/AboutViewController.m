//
//  AboutViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-5-2.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "AboutViewController.h"
#import "MainViewController.h"
#import "VersionDetailViewController.h"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    //    [topView setBackgroundColor:[UIColor colorWithRed:0.15 green:0.6 blue:0.88 alpha:1]];
    [topView setBackgroundColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.view addSubview:topView];
    
    self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setFrame:CGRectMake(10, 0, 44, 44)];
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.backBtn];
    
    self.mainView=[[UIView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    
    self.aboutLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 10, 80,44)];
    self.aboutLabel.text=@"About";
    self.aboutLabel.font=[UIFont boldSystemFontOfSize:16.0];
    
    self.versionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self initAndSetButtonStyle:self.versionBtn setY:[self getY:self.aboutLabel]+5 title:@"当前版本:v1.0"];

    self.webSiteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self initAndSetButtonStyle:self.webSiteBtn setY:[self getY:self.versionBtn]+5 title:@"www.yrq110.com"];
    
    self.ownerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self initAndSetButtonStyle:self.ownerBtn setY:[self getY:self.webSiteBtn]+5 title:@"yrq110_bistu"];
    
    self.otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, [self getY:self.ownerBtn]+5, 80, 44)];
    self.otherLabel.text=@"Other";
    self.otherLabel.font=[UIFont boldSystemFontOfSize:16.0];
    
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self initAndSetButtonStyle:self.shareBtn setY:[self getY:self.otherLabel]+5 title:@"推荐给好友"];
    
    self.versionDetailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self initAndSetButtonStyle:self.versionDetailBtn setY:[self getY:self.shareBtn]+5 title:@"版本详情"];
    [self.versionDetailBtn addTarget:self action:@selector(goToVersionDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.aboutLabel];
    [self.mainView addSubview:self.versionBtn];
    [self.mainView addSubview:self.webSiteBtn];
    [self.mainView addSubview:self.ownerBtn];
    [self.mainView addSubview:self.otherLabel];
    [self.mainView addSubview:self.shareBtn];
    [self.mainView addSubview:self.versionDetailBtn];
    [self.view addSubview:self.mainView];
}


-(void)backView:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        [MainVC.ddMenu showLeftController:NO];
    }];
}



-(void)initAndSetButtonStyle:(UIButton*)btn setY:(CGFloat)Y title:(NSString*)title
{
    [btn setFrame:CGRectMake(10,Y, self.view.frame.size.width-20, 44)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0,10,0,0);
    btn.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    
}


-(CGFloat)getY:(UIView*)view
{
    return view.frame.origin.y+view.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goToVersionDetailView:(id)sender
{
    VersionDetailViewController *VDView=[[VersionDetailViewController alloc]init];
    [VDView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:VDView animated:YES completion:nil];

}


@end
