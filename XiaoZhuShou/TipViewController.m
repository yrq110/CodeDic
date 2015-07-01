//
//  TipViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-5-14.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "TipViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#define HEIGHT 568
@interface TipViewController ()

@end

@implementation TipViewController

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
    
    self.view.backgroundColor=[UIColor grayColor];
    self.pageScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT)];
    self.pageScroll.contentSize=CGSizeMake(5*320, HEIGHT);
    self.pageScroll.pagingEnabled=YES;
    self.pageScroll.delegate=self;
    
    self.gotoMainViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.gotoMainViewBtn.frame = CGRectMake(110, 345, 100, 35);
    [self.gotoMainViewBtn addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.image = [UIImage imageNamed:@"scroll_1.png"];
    
    UIImageView *imageView2 = [[UIImageView alloc]init];
    imageView2.image = [UIImage imageNamed:@"scroll_2.png"];
    
    UIImageView *imageView3 = [[UIImageView alloc]init];
    imageView3.image = [UIImage imageNamed:@"scroll_3.png"];
    
    UIImageView *imageView4 = [[UIImageView alloc]init];
    imageView4.image = [UIImage imageNamed:@"scroll_4.png"];
    
    UIImageView *returnView = [[UIImageView alloc]init];
    returnView.image = [UIImage imageNamed:@"scroll_5.png"];
    
    [returnView addSubview:self.gotoMainViewBtn];
    returnView.userInteractionEnabled=YES;
    [self.pageScroll addSubview:returnView];
    
    for (int i=0; i<5; i++) {
        if (i==0) {
            [self.pageScroll addSubview:imageView1];
            imageView1.frame = CGRectMake(i*320, 0, 320, HEIGHT);
        }else if (i==1) {
            [self.pageScroll addSubview:imageView2];
            imageView2.frame = CGRectMake(i*320, 0, 320, HEIGHT);
        }else if(i==2){
            [self.pageScroll addSubview:imageView3];
            imageView3.frame = CGRectMake(i*320, 0, 320, HEIGHT);
        }else if(i==3){
            [self.pageScroll addSubview:imageView4];
            imageView4.frame = CGRectMake(i*320, 0, 320, HEIGHT);
        }else if(i==4){
            returnView.frame = CGRectMake(i*320, 0, 320, HEIGHT);
            [self.pageScroll addSubview:returnView];
        }
    }
    
    [self.view addSubview:self.pageScroll];
    
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.frame=CGRectMake(141,364,50,50);
    [self.pageControl setNumberOfPages:5];
    self.pageControl.currentPage=0;
    [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)gotoMainView:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    [MainVC.ddMenu showRootController:NO];
    [self presentViewController:MainVC animated:NO completion:nil];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset=scrollView.contentOffset;
    self.pageControl.currentPage=offset.x/320.0f;
    self.pageControl.hidden = NO;
    NSLog(@"%d",self.pageControl.currentPage);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    self.pageControl.currentPage=offset.x/320.0f;
    self.pageControl.hidden = YES;
}

-(void)pageTurn:(UIPageControl *)aPageControl
{
    int whichPage=aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    self.pageScroll.contentOffset=CGPointMake(320*whichPage, 0);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
