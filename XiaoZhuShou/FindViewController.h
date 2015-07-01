//
//  FindViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-4-20.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeSQL.h"

@interface FindViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UISearchDisplayController *searchController;
@property(strong,nonatomic)UISearchBar *searchBar;
@property(strong,nonatomic)NSMutableArray *data;
@property(strong,nonatomic)NSMutableArray *filterData;
@property(strong,nonatomic)CodeSQL *dataWorker;
@property(strong,nonatomic)NSMutableArray *arrPLID;
@property(strong,nonatomic)NSMutableArray *arrPLTitle;
@property(strong,nonatomic)NSMutableArray *arrCatalogueClass;
@property(strong,nonatomic)NSMutableArray *arrCatalogueTitle;
@property(strong,nonatomic)NSMutableArray *arrCatalogueExplain;
@property(strong,nonatomic)NSMutableArray *filterPLTitle;
@property(strong,nonatomic)NSMutableArray *filterCatalogueClass;
@property(strong,nonatomic)NSMutableArray *filterCatalogueTitle;
@property(strong,nonatomic)NSMutableArray *filterCatalogueExplain;
@property(strong,nonatomic)NSArray *filterEchoTitle;
@property(strong,nonatomic)NSArray *filterEchoExplain;
@property(strong,nonatomic)NSMutableArray *PLIDArr;
@property(strong,nonatomic)NSMutableArray *CatalogueArr;
@end
