//
//  MainViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"
#import "DDMenuController.h"
#import "MenuViewController.h"
#import "SubMenuViewController.h"
#import "CodeSQL.h"
@class DDMenuController;
@interface MainViewController : ViewController

@property (strong,nonatomic) UINavigationController *nav;
@property (strong,nonatomic) DDMenuController *ddMenu;
@property (strong,nonatomic) ContentViewController *ConVC;
@property (strong,nonatomic) SubMenuViewController *submenuVC;
@property (strong,nonatomic) CodeSQL *dataWorker;
+(id)shareMainViewController;
@end
