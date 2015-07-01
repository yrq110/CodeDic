//
//  MenuViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "ViewController.h"
#import "CodeSQL.h"

@interface MenuViewController : ViewController<UITableViewDelegate,UITableViewDataSource>{
}
@property(strong,nonatomic)UITableView *mainMenu;
@property(strong,nonatomic)NSArray *arr1;
@property(strong,nonatomic)NSArray *arr3;
@property(strong,nonatomic)NSMutableArray *arrAll;
@property(strong,nonatomic)CodeSQL *dataWorker;
@property(strong,nonatomic)UISwitch *nightSwitch;
@property(strong,nonatomic)UIButton *aboutBtn;
@property(strong,nonatomic)UILabel *appTitle;
@property int PLID;
-(void)returnMain:(id)sender;
-(void)changeColor:(BOOL)isOn;
@end
