//
//  ContentViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-1-13.
//  Copyright (c) 2015年 yrq. All rights reserved.
//
#define grayRGB 0.8
#define redRGB 0.73
#import "ContentViewController.h"
#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UMSocial.h"
@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

CGPoint beginPoint,movePoint;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createSQL];
    [self basedScrollView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

-(void)basedScrollView
{
    self.title=@"小助手";
//    CGRect frame= self.navigationItem.titleView.frame;
//    frame.origin.x-=40;
//    self.navigationItem.titleView.frame=frame;
//    UIColor * color=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
//    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes=dict;
    self.isInitView=0;
//    NSLog(@"init is %d",self.isInitView);
    [self LoadView];
}

-(void)LoadView
{
    self.noteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:@"title-btn-list@2x.png"];
    [self.noteBtn setFrame:CGRectMake(img.size.width/2+20, 9, img.size.height/2, img.size.height/2)];
//    NSLog(@"height is %f,",img.size.height/2);
    [self.noteBtn setBackgroundImage:[UIImage imageNamed:@"icon_edit_n.png"] forState:UIControlStateNormal];
    [self.noteBtn addTarget:self action:@selector(showNoteTextView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.noteBtn];
    
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setFrame:CGRectMake(self.view.frame.size.width-img.size.width+10, 9, img.size.height/2, img.size.height/2)];
    [self.shareBtn setBackgroundImage:[UIImage imageNamed:@"icon_recommend_share_n.png"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(showShareSDKView:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.shareBtn];
    
    self.collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectBtn setFrame:CGRectMake(self.view.frame.size.width-img.size.width*1.3, 9, img.size.height/2, img.size.height/2)];
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_tips_cancel.png"] forState:UIControlStateNormal];
    [self.collectBtn addTarget:self action:@selector(isCollect:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.collectBtn];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 524)];
    self.myView=[[UIView alloc]init];
    
    self.titlee=[[UILabel alloc]init];
    self.classs=[[UILabel alloc]init];
    self.usage=[[UILabel alloc]init];
    self.paraphrase=[[UILabel alloc]init];
    self.example=[[UILabel alloc]init];
    
    self.titlee.text=@"欢迎使用";
    self.classs.text=@"Welcome";
    self.usage.text=@"  版本v1.0";
    self.paraphrase.text=@"编程小助手";
    self.example.text = @"introduction\n message\n {\n   made by yrq;\n   school from bistu;\n}";
    
    self.titlee.font=[UIFont boldSystemFontOfSize:30.0];
    self.classs.font=[UIFont systemFontOfSize:10.0];
    self.usage.font=[UIFont systemFontOfSize:15.0];
    self.paraphrase.font=[UIFont systemFontOfSize:15.0];
    
    self.titlee.frame=CGRectMake(20, 30, 140, 30);
    self.classs.frame=CGRectMake(150, 40, 100, 20);
    self.usage.frame=CGRectMake(20, 70, 100, 30);
    self.paraphrase.frame=CGRectMake(20, 110, 200, 30);
    self.example.frame=CGRectMake(20, 150, 280, 150);
    
    self.titlee.textColor=[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
    [self.titlee setNumberOfLines:0];
    [self.titlee setBackgroundColor:[UIColor clearColor]];
    
    [self.classs setNumberOfLines:0];
    [self.classs setBackgroundColor:[UIColor clearColor]];
    
    [self.usage setNumberOfLines:0];
    [self.usage setBackgroundColor:[UIColor colorWithRed:grayRGB green:grayRGB blue:grayRGB alpha:1.0]];
    CGRect rectU=self.usage.frame;
    rectU.size.width=280.0;
    self.usage.frame=rectU;
    
    [self.paraphrase setNumberOfLines:0];
    [self.paraphrase setBackgroundColor:[UIColor clearColor]];
    
    [self.example setNumberOfLines:0];
    UIFont *font=[UIFont systemFontOfSize:15.0];
    CGSize size = CGSizeMake(280,3000);
    CGSize labelsize = [self.example.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect newFrame = self.example.frame;
    newFrame.size.height = labelsize.height;
    self.example.frame = newFrame;
    [self.example sizeToFit];
    CGRect rect=self.example.frame;
    rect.size.width=280.0;
    self.example.frame=rect;
    
    self.example.backgroundColor=[UIColor colorWithRed:grayRGB green:grayRGB blue:grayRGB alpha:1.0];
    
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.bounces=NO;
    
    
    [self.myView addSubview:self.titlee];
    [self.myView addSubview:self.classs];
    [self.myView addSubview:self.usage];
    [self.myView addSubview:self.paraphrase];
    [self.myView addSubview:self.example];
    [self.scrollView addSubview:self.myView];
    [self.view addSubview:self.scrollView];
    
    [self.titlee release];
    [self.classs release];
    [self.usage release];
    [self.paraphrase release];
    [self.example release];
    
    self.panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveEditView:)];
    
    self.noteEditView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 160, 80)];
    [self.noteEditView setHidden:YES];
    self.noteEditView.delegate=self;
    self.noteEditView.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]CGColor];
    self.noteEditView.layer.borderWidth = 3.0;
    self.noteEditView.layer.cornerRadius = 8.0f;
    [self.noteEditView.layer setMasksToBounds:YES];
    [self.noteEditView addGestureRecognizer:self.panGesture];
    if (self.isInitView==0) {
        self.noteEditView.text=@"Welcome";
    }else if ([[self.dataWorker selectNoteAtPLID:self.PLID :self.CatalogueID] count]!=0) {
        self.noteEditView.text=[[[self.dataWorker selectNoteAtPLID:self.PLID :self.CatalogueID]objectAtIndex:0]objectAtIndex:0];
    }
    
    [self.view addSubview:self.noteEditView];
    
    
    self.tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelEditing:)];
    [self.view addGestureRecognizer:self.tapGesture];
    
    self.noteEnable=NO;
    self.prePoint=CGPointMake(0, 0);
    self.isQuitView=NO;
    self.caSwitch=[CATransition animation];
    self.caSwitch.delegate=self;
    self.caSwitch.duration=1;
    self.caSwitch.timingFunction=UIViewAnimationCurveEaseInOut;
    self.caSwitch.type=@"rippleEffect";
}

- (void)createSQL
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
    
}

-(void)PLNo:(int)PLNumber
{
    if (self.isBeginCustom==NO) {
        self.SelectPLNo=PLNumber;
        self.PLID=PLNumber;
        self.CatalogueID=0;
        NSArray *arr=[self.dataWorker selectPLData];
        //选择加载语言的初始界面数据
        for (int i=0; i<[arr count]; i++) {
            if (self.SelectPLNo==i) {
                self.array=[self.dataWorker selectCatalogue:i :0];
                if ([self.array count]!=0) {
                    self.isEmpty=NO;
                    self.title=[[arr objectAtIndex:i]objectAtIndex:0];
                    [self LoadText:self.array];
                }else{
                    self.isEmpty=YES;
                    [self isAlert];
                }
                
            }
        }
    }
}

-(void)CaNo:(int)CatalogueNumber
{
    //加载条目的详细信息
    self.CatalogueID=CatalogueNumber;
    if (self.isBeginCustom==NO) {
        self.array=[self.dataWorker selectCatalogue:self.SelectPLNo :CatalogueNumber];
        if ([self.array count]!=0) {
            [self LoadText:self.array];
        }
    }
}

-(void)CaCollect:(int)CatalogueNumber
{
    self.CatalogueID=CatalogueNumber;
    if (self.isBeginCustom==NO) {
        self.arrayClc=[self.dataWorker selectCollect:self.SelectPLNo :CatalogueNumber];
        if ([self.arrayClc count]!=0) {
            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_tips_ok.png"] forState:UIControlStateNormal];
        }else{
            [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_tips_cancel.png"] forState:UIControlStateNormal];
        }
    }
}

-(void)NoteNo:(int)plID :(int)catalogueID
{
    if ([[self.dataWorker selectNoteAtPLID:plID :catalogueID] count]!=0) {
        self.noteEditView.text=[[[self.dataWorker selectNoteAtPLID:plID :catalogueID]objectAtIndex:0]objectAtIndex:0];
    }else{
        self.noteEditView.text=@"";
    }
}


-(void)LoadText:(NSArray*)arr
{
    NSString *strTitle=[[arr objectAtIndex:0]objectAtIndex:0];
    UIFont *fontTitle = [UIFont boldSystemFontOfSize:30.0];
    CGSize sizeTitle = [strTitle sizeWithFont:fontTitle constrainedToSize:CGSizeMake(280.0f, 30.0f)
                                lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rectTitle=self.titlee.frame;
    rectTitle.size=sizeTitle;
    [self.titlee setText:strTitle];
    [self.titlee setFrame:rectTitle];
    
    self.classs.text=[[arr objectAtIndex:0]objectAtIndex:1];
    [self moveLabelX:self.classs :self.titlee];
    
    self.usage.text=[[arr objectAtIndex:0]objectAtIndex:4];
    [self sizeToFit:self.usage atFont:15 atSizeX:280 atSizeY:3000];
    CGRect rectU=self.usage.frame;
    rectU.size.width=280.0;
    self.usage.frame=rectU;
    
    
    self.paraphrase.text=[[arr objectAtIndex:0]objectAtIndex:2];
    [self sizeToFit:self.paraphrase atFont:15 atSizeX:280 atSizeY:3000];
    [self moveLabelY:self.paraphrase :self.usage :YES];
    
    self.example.text=[[arr objectAtIndex:0]objectAtIndex:3];
    [self sizeToFit:self.example atFont:15 atSizeX:280 atSizeY:3000];
    [self moveLabelY:self.example :self.paraphrase :YES];
    
    self.scrollView.contentSize=CGSizeMake(320, self.titlee.frame.size.height+self.classs.frame.size.height+self.usage.frame.size.height+self.paraphrase.frame.size.height+self.example.frame.size.height+84);
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void)sizeToFit:(UILabel*)label atFont:(CGFloat)fontNo atSizeX:(CGFloat)sizeX atSizeY:(CGFloat)sizeY
{
    UIFont *font=[UIFont systemFontOfSize:fontNo];
    CGSize size = [label.text sizeWithFont:font constrainedToSize:CGSizeMake(sizeX,sizeY) lineBreakMode:NSLineBreakByWordWrapping];
    CGRect newFrame = label.frame;
    newFrame.size.height = size.height;
    label.frame = newFrame;
    [label sizeToFit];
}

-(void)moveLabelX:(UILabel*)labelA :(UILabel*)labelB
{
    CGRect rect=labelA.frame;
    rect.origin.x=labelB.frame.origin.x+labelB.frame.size.width+10;
    labelA.frame=rect;
}

-(void)moveLabelY:(UILabel*)labelA :(UILabel*)labelB :(BOOL)isWidth
{
    CGRect rect=labelA.frame;
    if (isWidth==YES) {
        rect.size.width=280.0;
    }
    rect.origin.y=labelB.frame.origin.y+labelB.frame.size.height+10;
    labelA.frame=rect;
}

-(void)changeColor:(BOOL)isOn
{
    self.isChangedColor=isOn;
    if (self.isChangedColor==YES) {
        self.titlee.textColor=[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
        self.classs.textColor=[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        self.paraphrase.textColor=[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        self.example.textColor=[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        self.usage.textColor=[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
        
        self.titlee.backgroundColor=[UIColor clearColor];
        self.classs.backgroundColor=[UIColor clearColor];
        self.paraphrase.backgroundColor=[UIColor clearColor];
        self.example.backgroundColor=[UIColor colorWithRed:6.0/255.0 green:18.0/255.0 blue:164.0/255.0 alpha:1];
        self.usage.backgroundColor=[UIColor colorWithRed:6.0/255.0 green:18.0/255.0 blue:164.0/255.0 alpha:1];
        self.view.backgroundColor=[UIColor colorWithRed:3.0/255.0 green:9.0/255.0 blue:67.0/255.0 alpha:1];
    }else{
        self.titlee.textColor=[UIColor colorWithRed:0.73 green:0 blue:0 alpha:1.0];
        self.classs.textColor=[UIColor blackColor];
        self.paraphrase.textColor=[UIColor blackColor];
        self.example.textColor=[UIColor blackColor];
        self.usage.textColor=[UIColor blackColor];
        
        self.titlee.backgroundColor=[UIColor clearColor];
        self.classs.backgroundColor=[UIColor clearColor];
        self.paraphrase.backgroundColor=[UIColor clearColor];
        self.example.backgroundColor=[UIColor colorWithRed:grayRGB green:grayRGB blue:grayRGB alpha:1.0];
        self.usage.backgroundColor=[UIColor colorWithRed:grayRGB green:grayRGB blue:grayRGB alpha:1.0];
        self.view.backgroundColor=[UIColor whiteColor];
    
    }
}

-(void)isAlert
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未添加条目" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)showNoteTextView:(id)sender
{
    
    if (self.noteEnable==NO) {
        [self.noteEditView setHidden:NO];
        self.noteEnable=YES;
        if (self.prePoint.x==0&&self.prePoint.y==0) {
            [self.noteEditView setFrame:CGRectMake(0, 0, 160, 80)];
        }
        else{
        [UIView animateWithDuration:1 animations:^{
            [self.noteEditView setFrame:CGRectMake(0, 0, 160, 80)];}
                         completion:^(BOOL finished){
                             [[self.noteEditView layer]addAnimation:self.caSwitch forKey:nil];
                         }];
            self.prePoint=CGPointMake(0, 0);
        }
        self.noteEditView.editable=YES;
    }else{
        [self.noteEditView setHidden:YES];
        self.noteEditView.editable=NO;
        self.noteEnable=NO;
    }

}


-(void)moveEditView:(UIPanGestureRecognizer*)sender
{
    if (self.noteEditView.isFirstResponder==YES) {
        self.panGesture.enabled=NO;
    }
    
    if (sender.state==UIGestureRecognizerStateBegan) {
        beginPoint=[sender locationInView:self.view];
    }
    
    if (sender.state==UIGestureRecognizerStateChanged) {
        movePoint=[sender locationInView:self.view];
        float moveX=movePoint.x-beginPoint.x;
        float moveY=movePoint.y-beginPoint.y;
        
        CGPoint pt=CGPointMake(moveX+self.prePoint.x, moveY+self.prePoint.y);
        CGRect rect=self.noteEditView.frame;
        rect.origin=pt;
        [self.noteEditView setFrame:rect];
        
        CGRect rect2=self.noteEditView.frame;
        if ((self.noteEditView.frame.origin.x+self.noteEditView.frame.size.width)>320) {
            rect2.origin.x=320-self.noteEditView.frame.size.width;
        }
        if ((self.noteEditView.frame.origin.y+self.noteEditView.frame.size.height)>504) {
            rect2.origin.y=504-self.noteEditView.frame.size.height;
        }
        if (self.noteEditView.frame.origin.x<0) {
            rect2.origin.x=0;
        }
        if (self.noteEditView.frame.origin.y<0) {
            rect2.origin.y=0;
        }
        [self.noteEditView setFrame:rect2];
//        NSLog(@"x:%0.1f,y:%0.1f\n viewX:%0.1f,viewY:%0.1f",moveX,moveY,self.noteEditView.frame.origin.x,self.noteEditView.frame.origin.y);
    }
    
    if (sender.state==UIGestureRecognizerStateEnded) {
        movePoint=[sender locationInView:self.view];
        float moveX=movePoint.x-beginPoint.x;
        float moveY=movePoint.y-beginPoint.y;
        CGPoint pt=CGPointMake(moveX+self.prePoint.x, moveY+self.prePoint.y);
        CGRect rect=self.noteEditView.frame;
        rect.origin=pt;
        [self.noteEditView setFrame:rect];
        CGRect rect2=self.noteEditView.frame;
        if ((self.noteEditView.frame.origin.x+self.noteEditView.frame.size.width)>320) {
            rect2.origin.x=320-self.noteEditView.frame.size.width;
        }
        if ((self.noteEditView.frame.origin.y+self.noteEditView.frame.size.height)>504) {
            rect2.origin.y=504-self.noteEditView.frame.size.height;
        }
        if (self.noteEditView.frame.origin.x<0) {
            rect2.origin.x=0;
        }
        if (self.noteEditView.frame.origin.y<0) {
            rect2.origin.y=0;
        }
        [self.noteEditView setFrame:rect2];
        
        self.prePoint=CGPointMake(self.noteEditView.frame.origin.x, self.noteEditView.frame.origin.y);
//        NSLog(@"x is %0.1f,y is %0.1f",prePoint.x,prePoint.y);
    }
}


-(void)cancelEditing:(UITapGestureRecognizer*)sender
{
    [self.noteEditView resignFirstResponder];
    self.panGesture.enabled=YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:1 animations:^{
        [self.noteEditView setFrame:CGRectMake(80, 200, 160, 80)];}
                     completion:^(BOOL finished){
                         [[self.noteEditView layer]addAnimation:nil forKey:nil];
                     }];
    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
    [MainVC.ConVC.navigationItem.leftBarButtonItem setEnabled:NO];
    [MainVC.ConVC.navigationItem.rightBarButtonItem setEnabled:NO];
    [MainVC.ConVC.shareBtn setEnabled:NO];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect rect=self.noteEditView.frame;
    rect.origin=self.prePoint;
    [UIView animateWithDuration:1 animations:^{
        [self.noteEditView setFrame:rect];}
                     completion:^(BOOL finished){
                         [[self.noteEditView layer]addAnimation:nil forKey:nil];
                     }];
    self.panGesture.enabled=YES;
    if ([[self.dataWorker selectNoteAtPLID:self.PLID :self.CatalogueID] count]!=0) {
        if ([self isBlankString:textView.text]==NO) {
            [self.dataWorker updateNote:textView.text atPLID:self.PLID atCatalogueID:self.CatalogueID];
        }else{
            [self.dataWorker deleteFromNoteTable:self.PLID :self.CatalogueID];
        }
    }else{
        if ([self isBlankString:textView.text]==NO) {
            [self.dataWorker insertNote:textView.text :self.PLID :self.CatalogueID];
        }
    }
//    NSLog(@"%@",textView.text);
    MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
    [MainVC.ConVC.navigationItem.leftBarButtonItem setEnabled:YES];
    [MainVC.ConVC.navigationItem.rightBarButtonItem setEnabled:YES];
    [MainVC.ConVC.shareBtn setEnabled:YES];
}

-(void)setNoteViewInit
{
    self.noteEditView.text=@"";
    self.noteEditView.hidden=YES;
    self.noteEditView.editable=NO;
    self.prePoint=CGPointMake(0, 0);
    self.noteEnable=NO;
}

- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


-(void)showShareSDKView:(id)sender
{
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape]; 
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"553eeb0667e58ed991006457"
                                      shareText:@"编程小助手，编程好帮手"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms,UMShareToDouban,UMShareToFacebook,UMShareToTwitter, nil]
                                       delegate:nil];

}

-(void)isCollect:(id)sender
{
    if ([[self.dataWorker selectCollect:self.PLID :self.CatalogueID] count]!=0) {
        [self.dataWorker deleteFromCollectTable:self.PLID :self.CatalogueID];
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_tips_cancel.png"] forState:UIControlStateNormal];
    }else
    {
        [self.dataWorker insertCollect:self.PLID :self.CatalogueID];
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"icon_tips_ok.png"] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
