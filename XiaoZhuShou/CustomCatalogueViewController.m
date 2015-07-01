//
//  CustomCatalogueViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-7.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CustomCatalogueViewController.h"
#import "NewCatalogueViewController.h"
@interface CustomCatalogueViewController ()

@end

@implementation CustomCatalogueViewController

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
    
    [self initNavBar];
    [self initScrollView];
    [self initData];
    
    self.colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.773830F green:0.767224F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.773830F green:0.873416F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.873416F green:0.681577F blue:0.758009F alpha:0.5F],[UIColor whiteColor],[UIColor colorWithRed:0.615054F green:0.798404F blue:0.873416F alpha:0.5F], nil];
}

- (void)initNavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNote)];
}


- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 524)];
    self.scrollView.contentSize = CGSizeMake(320, 524);
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
}


- (void)initData
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self printCatalogue];
}

- (void)printCatalogue
{
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake(320, 416);
    NSMutableArray *array = [self.dataWorker selectCatalogueTitle:self.PLID];
//    NSLog(@"arrayload,PLID=%d",self.PLID);
//    NSLog(@"count is %d",[array count]);
    for (int i = 0; i < [array count]; i++) {
        CustomIndexView *note = [[CustomIndexView alloc] initWithFrame:CGRectMake(0,3+i*51, 320, 46)];
        note.delegate = self;
        note.titleLabel.text = [[array objectAtIndex:i] objectAtIndex:0];
//        NSLog(@"title = %@",note.titleLabel.text);
//        note.timeLabel.text = [[array objectAtIndex:i] objectAtIndex:1];
        note.ID = [[[array objectAtIndex:i] objectAtIndex:2] intValue];
        [self.scrollView addSubview:note];
        note.backgroundView.backgroundColor = [self.colorArray objectAtIndex:i%5];
        if (i>7) {
            self.scrollView.contentSize = CGSizeMake(320, 54+i*51);
        }
    }
}

- (void)createNote
{
    NewCatalogueViewController *new = [[NewCatalogueViewController alloc]init];
    new.title = @"新条目";
    new.PLID = self.PLID;
    new.isFirst = YES;
    [self.navigationController pushViewController:new animated:YES];
}

- (void)noteDidSelect:(CustomIndexView *)note
{
    NewCatalogueViewController *new = [[NewCatalogueViewController alloc]init];
    new.CatalogueID = note.ID;
    new.PLID = self.PLID;
    NSArray *array=[self.dataWorker selectCatalogue:self.PLID :note.ID];
    new.title = [[array objectAtIndex:0]objectAtIndex:0];
    new.isFirst = NO;
    [self.navigationController pushViewController:new animated:YES];
}

- (void)noteDidDelete:(CustomIndexView *)note
{
    [self.dataWorker deleteFromCatalogueTable:self.PLID :note.ID];
    
    [self printCatalogue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
