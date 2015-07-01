//
//  SubMenuViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-1-21.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "ViewController.h"

#import "CodeSQL.h"
@interface SubMenuViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *subMenu;
@property(strong,nonatomic)NSArray *arr;
@property(strong,nonatomic)CodeSQL *dataWorker;
@property(strong,nonatomic)UILabel *PLTitle;
@property int SelectNo;
@property int InitNo;
@property BOOL isChangedColor;
-(void)PLNo:(int)PLNumber;
-(void)changeColor:(BOOL)isOn;
@end
