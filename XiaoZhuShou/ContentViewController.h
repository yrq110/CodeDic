//
//  ContentViewController.h
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CodeSQL.h"

@interface ContentViewController : ViewController<UIAlertViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
}
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIView  *myView;
@property(assign,nonatomic)int SelectPLNo;
@property(strong,nonatomic)UIButton *noteBtn;
@property(strong,nonatomic)UIButton *shareBtn;
@property(strong,nonatomic)UIButton *collectBtn;
@property(strong,nonatomic)UILabel *titlee;
@property(strong,nonatomic)UILabel *classs;
@property(strong,nonatomic)UILabel *usage;
@property(strong,nonatomic)UILabel *paraphrase;
@property(strong,nonatomic)UILabel *example;
@property(strong,nonatomic)CodeSQL *dataWorker;
@property(strong,nonatomic)NSArray *array;
@property(strong,nonatomic)NSArray *arrayClc;
@property(strong,nonatomic)UITextView *noteEditView;
@property(strong,nonatomic)UIPanGestureRecognizer *panGesture;
@property(strong,nonatomic)UITapGestureRecognizer *tapGesture;
@property(strong,nonatomic)CATransition *caSwitch;
@property BOOL noteEnable;
@property int PLID;
@property int CatalogueID;
@property int isInitView;
@property BOOL isQuitView;
@property BOOL isChangedColor;
@property CGPoint prePoint;
@property(assign,nonatomic)BOOL isEmpty;
@property BOOL isBeginCustom;
-(void)PLNo:(int)PLNumber;
-(void)CaNo:(int)CatalogueNumber;
-(void)CaCollect:(int )CatalogueNumber;
-(void)changeColor:(BOOL)isOn;
-(void)isAlert;
-(void)setNoteViewInit;
-(void)NoteNo:(int)plID :(int)catalogueID;
@end
