//
//  MainViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

static  MainViewController  *MainVC;

+(id)shareMainViewController
{
    if (MainVC==nil)
    {
        MainVC=[[MainViewController alloc]init];
    }
    return MainVC;
}


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
}

-(void)viewDidAppear:(BOOL)animated
{			
    [super viewDidAppear:animated];
//    sleep(3);
    
    self.ConVC=[[ContentViewController alloc]init];
    
    self.nav=[[UINavigationController alloc]initWithRootViewController:self.ConVC];
    
    self.ddMenu=[[DDMenuController alloc]initWithRootViewController:self.nav];
    
    MenuViewController *menuVC=[[MenuViewController alloc]init];
    self.ddMenu.leftViewController=menuVC;

    self.submenuVC=[[SubMenuViewController alloc]init];
    self.ddMenu.rightViewController=self.submenuVC;
    
    [self presentViewController:self.ddMenu animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
