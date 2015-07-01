//
//  CustomCatalogueViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-4-7.
//  Copyright (c) 2015年 yrq. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CustomIndexView.h"
#import "CodeSQL.h"
@interface CustomCatalogueViewController : UIViewController<CustomIndexDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CodeSQL *dataWorker;
@property (strong, nonatomic) NSArray *colorArray;
@property int PLID;

@end