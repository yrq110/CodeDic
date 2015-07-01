//
//  NoteManageViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-5-5.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "NoteManageViewController.h"
#import "MainViewController.h"
@interface NoteManageViewController ()

@end

@implementation NoteManageViewController

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
    
    self.title=@"笔记管理";
    [self initNavBar];
    [self initScrollView];
    [self initData];
    self.colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.773830F green:0.767224F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.773830F green:0.873416F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.873416F green:0.681577F blue:0.758009F alpha:0.5F],[UIColor whiteColor],[UIColor colorWithRed:0.615054F green:0.798404F blue:0.873416F alpha:0.5F], nil];
}

- (void)initNavBar
{
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToMenu)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
}

- (void)initScrollView
{
    self.scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 524)];
    self.scrollView.contentSize=CGSizeMake(320, 524);
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor=[UIColor clearColor];
}

- (void)initData
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self printNoteBookIndex];
}

- (void)printNoteBookIndex
{
    
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake(320, 416);
    
    NSMutableArray *array = [self.dataWorker selectNoteData];
    for (int i = 0; i < [array count]; i++) {
        CustomIndexView *codeIndex = [[CustomIndexView alloc] initWithFrame:CGRectMake(0, 3 + i*51, 320, 46)];
        codeIndex.delegate = self;
        codeIndex.titleLabel.text = [[array objectAtIndex:i] objectAtIndex:0];
        codeIndex.timeLabel.text = @"";
        codeIndex.ID = [[[array objectAtIndex:i] objectAtIndex:1] intValue];
        codeIndex.ID2 = [[[array objectAtIndex:i] objectAtIndex:2] intValue];
        [self.scrollView addSubview:codeIndex];
        codeIndex.backgroundView.backgroundColor = [self.colorArray objectAtIndex:i%5];
        if (i>7) {
            self.scrollView.contentSize = CGSizeMake(320, 90+i*51);
        }
    }
    //    [self snowEffect];
}



- (void)backToMenu
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        MainVC.ConVC.isBeginCustom=NO;
        [MainVC.ddMenu showLeftController:NO];
    }];
    
}



- (void)cancel
{
}


- (void) withMessage:(NSString *)message
{

}


- (void)noteDidDelete:(CustomIndexView *)note
{
//    NSMutableArray *array = [self.dataWorker selectNoteData];
    
    [self.dataWorker deleteFromNoteTable:note.ID :note.ID2];
        
    [self printNoteBookIndex];
}


-(void)noteDidSelect:(CustomIndexView *)note
{
//    CustomCatalogueViewController *ccVC = [[CustomCatalogueViewController alloc] init];
//    ccVC.PLID = note.ID;
//    NSArray *array=[self.dataWorker selectPLTitle:note.ID];
//    ccVC.title = [[array objectAtIndex:0]objectAtIndex:0];
//    [self.navigationController pushViewController:ccVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
