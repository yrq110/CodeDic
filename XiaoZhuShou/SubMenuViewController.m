//
//  SubMenuViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-21.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "SubMenuViewController.h"
#import "MainViewController.h"

@interface SubMenuViewController ()

@end

@implementation SubMenuViewController

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
    
    self.dataWorker=[[CodeSQL alloc]init];
    [self.dataWorker createDB];
    
    self.subMenu=[[UITableView alloc]initWithFrame:CGRectMake(40, 44, 280, 504) style:UITableViewStylePlain];
    self.subMenu.delegate=self;
    self.subMenu.dataSource=self;
    
    UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
    [self.subMenu setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
    [self.subMenu setSeparatorColor:lineColor];
    [self.view addSubview:self.subMenu];
    
    self.subMenu.bounces=NO;
    [self setExtraCellLineHidden:self.subMenu];
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(40, 0, self.view.frame.size.width-40, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
    self.PLTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 44)];
    self.PLTitle.font=[UIFont boldSystemFontOfSize:17.0];
    self.PLTitle.textColor=[UIColor whiteColor];
//    self.PLTitle.textColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
    self.PLTitle.textAlignment=NSTextAlignmentCenter;
    self.PLTitle.backgroundColor=[UIColor clearColor];
    [topView addSubview:self.PLTitle];
    [self.view addSubview:topView];
}

-(void)viewWillAppear:(BOOL)animated
{
    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
    self.InitNo=MainVC.ConVC.isInitView;
    [MainVC.ConVC setNoteViewInit];
    if (self.InitNo!=0) {
        NSString *string=@"当前语言:";
        NSString *combineS=[string stringByAppendingString:[[[self.dataWorker selectPLTitle:self.SelectNo]objectAtIndex:0]objectAtIndex:0]];
        self.PLTitle.text=combineS;
    }else{
        self.PLTitle.text=@"请先选择语言";
    }
   
    [self.subMenu reloadData];
}

-(void)PLNo:(int)PLNumber
{
    self.SelectNo=PLNumber;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.InitNo==0) {
//        NSLog(@"Im here!");
        return 1;
    }else
    {
        switch (section) {
        case 0:
                if ([[self.dataWorker selectCatalogueTitle:self.SelectNo] count]!=0) {
//                    NSLog(@"SelectNo is %d,total is %d",self.SelectNo,[[self.dataWorker selectCatalogueTitle:self.SelectNo] count]);
                    return [[self.dataWorker selectCatalogueTitle:self.SelectNo] count];
                    
                }else{
//                    NSLog(@"Count is 0,SelectNo is %d",self.SelectNo);
                    return 1;
                }
            
            break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cellName";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(230, 0, 50, cell.frame.size.height)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:10.0];
        label.textColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
        label.tag=1;
        [cell.contentView addSubview:label];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:16.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0:
            if (self.InitNo==0) {
                cell.textLabel.text=@"请先在左侧菜单选择程序语言";
            }else{
                if ([[self.dataWorker selectCatalogue:self.SelectNo :indexPath.row] count]!=0) {
                    cell.textLabel.text=[[[self.dataWorker selectCatalogue:self.SelectNo :indexPath.row]objectAtIndex:0]objectAtIndex:0];
                    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:1];
                    label2.text=[[[self.dataWorker selectCatalogue:self.SelectNo :indexPath.row]objectAtIndex:0]objectAtIndex:1];
                }
            
            break;
            }
    }
    
    cell.selectedBackgroundView=[[[UIView alloc]initWithFrame:cell.frame]autorelease];
    UIColor *color=[[UIColor alloc]init];
    if (self.isChangedColor==YES) {
        color=[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0];
        cell.textLabel.textColor=[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
    }else{
        color=[UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
        cell.textLabel.textColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
    }
    
    cell.selectedBackgroundView.backgroundColor=color;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    if (indexPath.section==0) {
        if (self.InitNo==0) {
            MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
            [MainVC.ddMenu showRootController:YES];
        }else{
        MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
        [MainVC.ConVC CaNo:indexPath.row];
        [MainVC.ConVC CaCollect:indexPath.row];
        [MainVC.ConVC NoteNo:self.SelectNo :indexPath.row];
        [MainVC.ddMenu showRootController:YES];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *header=[[UIImageView alloc]init];
    UIColor *color=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
    header.backgroundColor=color;
    return header;
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}

-(void)changeColor:(BOOL)isOn
{
    self.isChangedColor=isOn;
    if (self.isChangedColor==YES) {
        UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
        [self.subMenu setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:9.0/255.0 blue:67.0/255.0 alpha:1]];
        [self.subMenu setSeparatorColor:lineColor];
        [self.subMenu reloadData];
    }else{
        UIColor *lineColor=[[UIColor alloc]initWithRed:0.15 green:0.6 blue:0.88 alpha:1];
        [self.subMenu setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]];
        [self.subMenu setSeparatorColor:lineColor];
        [self.subMenu reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
