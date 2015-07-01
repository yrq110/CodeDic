//
//  CollectManageViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-5-15.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CollectManageViewController.h"
#import "MainViewController.h"
@interface CollectManageViewController ()

@end

@implementation CollectManageViewController

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
    self.title=@"收藏的条目";
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 524)];
    self.scrollView.contentSize = CGSizeMake(320, 524);
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
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
    
    NSMutableArray *array = [self.dataWorker selectCollectData];
//    NSLog(@"count is %d",[array count]);
    for (int i = 0; i < [array count]; i++) {
        CustomIndexView *codeIndex = [[CustomIndexView alloc] initWithFrame:CGRectMake(0, 3 + i*51, 320, 46)];
        codeIndex.delegate = self;
        codeIndex.titleLabel.text =[[[self.dataWorker selectPLTitle:[[[array objectAtIndex:i] objectAtIndex:0]intValue]]objectAtIndex:0]objectAtIndex:0];
        codeIndex.subTitleLabel.text = [[[self.dataWorker selectCatalogue:[[[array objectAtIndex:i] objectAtIndex:0]intValue] :[[[array objectAtIndex:i] objectAtIndex:1]intValue]]objectAtIndex:0]objectAtIndex:0];
        
        [codeIndex.titleLabel sizeToFit];
        CGRect rect1=codeIndex.titleLabel.frame;
        rect1.origin.y+=15;
        codeIndex.titleLabel.frame=rect1;
        
        CGRect rect=codeIndex.subTitleLabel.frame;
        rect.origin.x=codeIndex.titleLabel.frame.origin.x+codeIndex.titleLabel.frame.size.width+10;
        codeIndex.subTitleLabel.frame=rect;
        
        codeIndex.ID = [[[array objectAtIndex:i] objectAtIndex:0] intValue];
        codeIndex.ID2 = [[[array objectAtIndex:i] objectAtIndex:1] intValue];
        [self.scrollView addSubview:codeIndex];
        codeIndex.backgroundView.backgroundColor = [self.colorArray objectAtIndex:i%5];
        if (i>7) {
            self.scrollView.contentSize = CGSizeMake(320, 90+i*51);
        }
    }
}



- (void)backToMenu
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        MainVC.ConVC.isBeginCustom=NO;
        NSLog(@"No is %d",MainVC.submenuVC.SelectNo);
        [MainVC.ddMenu showLeftController:NO];
    }];
    
}


- (void)createNote
{
}


- (void)cancel
{
    [self.backView removeFromSuperview];
}


- (void) withMessage:(NSString *)message
{

}


- (void)noteDidDelete:(CustomIndexView *)note
{
    [self.dataWorker deleteFromCollectTable:note.ID :note.ID2];
    [self printNoteBookIndex];
}


-(void)noteDidSelect:(CustomIndexView *)note
{
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    [MainVC.ConVC PLNo:note.ID];
    [MainVC.submenuVC PLNo:note.ID];
    [MainVC.ConVC CaNo:note.ID2];
    [MainVC.ConVC NoteNo:note.ID :note.ID2];
    [MainVC.ddMenu showRootController:NO];
    MainVC.ddMenu.rootViewController.view.alpha=1;
    NSLog(@"PL is %d,Ca is %d",note.ID,note.ID2);
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
