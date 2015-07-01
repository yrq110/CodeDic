//
//  NoteManageViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-5-5.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CustomIndexView.h"
#import "CustomEditView.h"
#import "CodeSQL.h"

@interface NoteManageViewController : UIViewController<CustomEditViewDelegate,CustomIndexDelegate>
{
    CustomEditView *EditView;
    
}
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CodeSQL *dataWorker;
@property (strong, nonatomic) NSArray *colorArray;
@property (strong, nonatomic) NSString *string;
@property int GroupID;
@property (strong,nonatomic)UIView *backView;
@end
