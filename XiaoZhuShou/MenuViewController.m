//
//  MenuViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "MenuViewController.h"
#import "MainViewController.h"
#import "DDMenuController.h"
#import "ContentViewController.h"
#import "CustomViewController.h"
#import "FindViewController.h"
#import "AboutViewController.h"
#import "NoteManageViewController.h"
#import "CollectManageViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

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
    // Do any additional setup after loading the view from its nib.

    self.dataWorker=[[CodeSQL alloc]init];
    [self.dataWorker createDB];
    
    self.nightSwitch=[[UISwitch alloc]init];
    self.arr3=[NSArray arrayWithObjects:@"夜间模式",@"搜索",@"自定义",@"笔记",@"收藏",nil];
    self.arrAll=[self.dataWorker selectPLData];
    
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
    [self.view addSubview:topView];
    
    self.aboutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.aboutBtn setFrame:CGRectMake(140, 0, 44, 44)];
    [self.aboutBtn setBackgroundImage:[UIImage imageNamed:@"browser_home_press.png"] forState:UIControlStateNormal];
    [self.aboutBtn addTarget:self action:@selector(goToAboutView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.aboutBtn];
    
    self.appTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 24)];
    self.appTitle.text=@"编程小助手";
    self.appTitle.textColor=[UIColor whiteColor];
    self.appTitle.backgroundColor=[UIColor clearColor];
//    self.appTitle.font=[UIFont boldSystemFontOfSize:17.0f];
    self.appTitle.font=[UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.appTitle sizeToFit];
    [topView addSubview:self.appTitle];
    
    
    
    self.mainMenu=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 200, 504) style:UITableViewStylePlain];
    self.mainMenu.delegate=self;
    self.mainMenu.dataSource=self;
    
    UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
    [self.mainMenu setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [self.mainMenu setSeparatorColor:lineColor];
    [self.view addSubview:self.mainMenu];
    
    self.mainMenu.bounces=NO;
    [self setExtraCellLineHidden:self.mainMenu];
    
    self.PLID=99;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return [self.arr3 count];
            break;
        case 3:
            return [self.arrAll count]-8;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cellName";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
//    if (indexPath.section==2&&indexPath.row==0) {
//        cell.userInteractionEnabled=NO;
//    }
    
    if(self.PLID<4)
    {   if(indexPath.section==0&&indexPath.row==self.PLID)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if(self.PLID<8)
    {
        if(indexPath.section==1&&indexPath.row==(self.PLID-4))
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15.0];
//    if (!(indexPath.section==2&&indexPath.row==0)) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text=[[[self.dataWorker selectPLTitle:indexPath.row]objectAtIndex:0]objectAtIndex:0];
            break;
        case 1:
            cell.textLabel.text=[[[self.dataWorker selectPLTitle:indexPath.row+4]objectAtIndex:0]objectAtIndex:0];
            break;
        case 2:
            if (indexPath.row==0) {
                [self.nightSwitch setFrame:CGRectMake(120,10, 0, 0)];
                [self.nightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
                MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
                self.nightSwitch.on=MainVC.ConVC.isChangedColor;
                [cell addSubview:self.nightSwitch];
                cell.textLabel.text=@"夜间模式";
            }else{
                cell.textLabel.text=[self.arr3 objectAtIndex:indexPath.row];
            }
            break;
        case 3:
            if (([self.arrAll count]-8)!=0) {
                    cell.textLabel.text=[[[self.dataWorker selectPLTitle:indexPath.row+8]objectAtIndex:0]objectAtIndex:0];
            }else{
                    cell.textLabel.text=@"";
            }
    }
    cell.textLabel.font=[UIFont boldSystemFontOfSize:16.0f];
    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
    UIColor *color=[[UIColor alloc]init];
    if (self.nightSwitch.on==YES) {
        color=[UIColor greenColor];
        color=[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0];
        cell.textLabel.textColor=[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
    }else{
        color=[UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
        cell.textLabel.textColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
    }
    if (!(indexPath.section==2&&indexPath.row==0)) {
        cell.selectedBackgroundView.backgroundColor=color;
    }else{
        cell.selectedTextColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
    }
    
    return cell;
}


//cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
        MainVC.ConVC.isInitView=1;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self turnToConVC:0];
                    break;
                case 1:
                    [self turnToConVC:1];
                    break;
                case 2:
                    [self turnToConVC:2];
                    break;
            }
            break;
        case 1:
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                break;
                case 1:
                {
                    FindViewController *searchView=[[FindViewController alloc]init];
                    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
                    MainVC.ddMenu.rootViewController.view.alpha=0;
                    [searchView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                     [self presentViewController:searchView animated:YES completion:nil];
                }
                break;
                case 2:
                {
                    CustomViewController *editView=[[CustomViewController alloc]init];
                    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
                    MainVC.ConVC.isBeginCustom=YES;
                    MainVC.ddMenu.rootViewController.view.alpha=0;
                    UINavigationController *edit=[[UINavigationController alloc]initWithRootViewController:editView];
                    [edit setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:edit animated:YES completion:nil];
                }
                break;
                case 3:
                {
                    NoteManageViewController *noteView=[[NoteManageViewController alloc]init];
                    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
                    MainVC.ConVC.isBeginCustom=YES;
                    MainVC.ddMenu.rootViewController.view.alpha=0;
                    UINavigationController *note=[[UINavigationController alloc]initWithRootViewController:noteView];
                    [note setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:note animated:YES completion:nil];
                }
                break;
                case 4:
                {
                    CollectManageViewController *collectView=[[CollectManageViewController alloc]init];
                    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
                    MainVC.ddMenu.rootViewController.view.alpha=0;
                    UINavigationController *collect=[[UINavigationController alloc]initWithRootViewController:collectView];
                    [collect setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [self presentViewController:collect animated:YES completion:nil];
     
                }
                break;
            }
            break;
        case 3:
        {
            if ([self.arrAll count]!=8) {
                MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
                [MainVC.ConVC PLNo:indexPath.row+8];
                if (MainVC.ConVC.isEmpty==NO) {
                    [MainVC.submenuVC PLNo:indexPath.row+8];
                    [MainVC.ddMenu showRootController:YES];
                }else{
                    
                }
                
            }
        }
            break;
    }
}

//section标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//section标题视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *header=[[UIImageView alloc]init];
    UIColor *color=[[UIColor alloc]init];
//    if (self.nightSwitch.on==YES) {
//        color=[UIColor redColor];
//    }else{
        color=[UIColor colorWithRed:0.15 green:0.6 blue:0.88 alpha:1];
//    }
    
    header.backgroundColor=color;
    return header;
}

//消去多余cell边界
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.arrAll=[self.dataWorker selectPLData];
    
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    [MainVC.ConVC setNoteViewInit];
    if (MainVC.ConVC.isInitView!=0) {
        self.PLID=MainVC.ConVC.PLID;
    }
    self.nightSwitch.on=MainVC.ConVC.isChangedColor;
    [self.mainMenu reloadData];
}


//返回主视图
-(void)returnMain:(id)sender
{
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    [MainVC.ddMenu showRootController:YES];
}


-(void)turnToConVC:(int)No
{
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    [MainVC.ConVC PLNo:No];
    [MainVC.ConVC CaCollect:No];
    [MainVC.submenuVC PLNo:No];
    [MainVC.ConVC NoteNo:No :0];
    [MainVC.ddMenu showRootController:YES];
}


- (void) switchValueChanged:(id)sender{
    UISwitch* control = (UISwitch*)sender;
    MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
    if(control == self.nightSwitch){
        BOOL on = control.on;
        [MainVC.ConVC changeColor:on];
        [MainVC.submenuVC changeColor:on];
        [self.mainMenu reloadData];
        [self changeColor:on];
    }
}

-(void)changeColor:(BOOL)isOn
{
    if (isOn==YES) {
        UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
        [self.mainMenu setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:9.0/255.0 blue:67.0/255.0 alpha:1]];
        [self.mainMenu setSeparatorColor:lineColor];
    }else{
        UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
        [self.mainMenu setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
        [self.mainMenu setSeparatorColor:lineColor];
    }
}


-(void)goToAboutView:(id)sender
{
    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
    MainVC.ddMenu.rootViewController.view.alpha=0;
    AboutViewController *abView=[[AboutViewController alloc]init];
    [abView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:abView animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
