//
//  NewCatalogueViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-4-7.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CodeSQL.h"
#import "MainViewController.h"
@interface NewCatalogueViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate,UINavigationBarDelegate>
@property BOOL isFirst;
@property BOOL isDisappear; 

@property int CatalogueID;
@property int PLID;

@property (strong, nonatomic) UIView *screenView;
@property (strong, nonatomic) UITextField *clTitleTextField;
@property (strong, nonatomic) UITextField *clClassTextField;
@property (strong, nonatomic) UITextView *clUsageTextView;
@property (strong, nonatomic) UILabel *clUsageLabel;
@property (strong, nonatomic) UITextView *clExplainTextView;
@property (strong, nonatomic) UILabel *clExplainLabel;
@property (strong, nonatomic) UITextView *clExampleTextView;
@property (strong, nonatomic) UILabel *clExampleLabel;

@property (strong, nonatomic) CodeSQL *dataWorker;

@end


