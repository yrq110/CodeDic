//
//  NewCatalogueViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-7.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "NewCatalogueViewController.h"

@interface NewCatalogueViewController ()

@end

@implementation NewCatalogueViewController

static int number;

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
    number = 1;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backView.backgroundColor = [UIColor darkGrayColor];
    backView.alpha = 0.8;
    [self.view addSubview:backView];
    [self initData];
    [self initNoteTextView];
    self.isDisappear = YES;
    
	// Do any additional setup after loading the view.
}

- (void)initData
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
}

- (void)initNoteTextView
{
    self.screenView=[[UIView alloc]initWithFrame:CGRectMake(0, 8, 320, 516)];
    self.screenView.backgroundColor=[UIColor clearColor];
    

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, 150, 33)];
    titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    titleView.layer.cornerRadius = 5;
    [self.view addSubview:titleView];
    self.clTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 7, 145, 20)];
    self.clTitleTextField.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
    self.clTitleTextField.backgroundColor = [UIColor clearColor];
    self.clTitleTextField.delegate = self;
    self.clTitleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.clTitleTextField.placeholder = @"输入标题";
    self.clTitleTextField.returnKeyType = UIReturnKeyNext;
    [titleView addSubview:self.clTitleTextField];
    self.clTitleTextField.adjustsFontSizeToFitWidth = YES;
    self.clTitleTextField.minimumFontSize = 2;
    
    UIView *classView = [[UIView alloc] initWithFrame:CGRectMake(165, 8, 135, 33)];
    classView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    classView.layer.cornerRadius = 5;
    [self.view addSubview:classView];
    self.clClassTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 7, 130, 20)];
    self.clClassTextField.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
    self.clClassTextField.backgroundColor = [UIColor clearColor];
    self.clClassTextField.delegate = self;
    self.clClassTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.clClassTextField.placeholder = @"输入类别";
    self.clClassTextField.returnKeyType = UIReturnKeyNext;
    [classView addSubview:self.clClassTextField];
    self.clClassTextField.adjustsFontSizeToFitWidth = YES;
    self.clClassTextField.minimumFontSize = 2;
    
    self.clUsageLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 60, 10)];
    self.clUsageLabel.text=@"用法:";
    [self.clUsageLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self.clUsageLabel setBackgroundColor:[UIColor clearColor]];
    [self.clUsageLabel setTextColor:[UIColor whiteColor]];
    [self.clUsageLabel sizeToFit];
    
    self.clUsageTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 65, 300, 100)];
    self.clUsageTextView.delegate=self;
    self.clUsageTextView.layer.cornerRadius=5;
    self.clUsageTextView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    self.clUsageTextView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
//    [self.view addSubview:self.clUsageTextView];
    
    self.clExplainLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 60, 10)];
    self.clExplainLabel.text=@"释义:";
    [self.clExplainLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self.clExplainLabel setBackgroundColor:[UIColor clearColor]];
    [self.clExplainLabel setTextColor:[UIColor whiteColor]];
    [self.clExplainLabel sizeToFit];
    
    self.clExplainTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 185, 300, 100)];
    self.clExplainTextView.delegate=self;
    self.clExplainTextView.layer.cornerRadius=5;
    self.clExplainTextView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    self.clExplainTextView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
//    [self.view addSubview:self.clExplainTextView];
    
    self.clExampleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 290, 60, 10)];
    self.clExampleLabel.text=@"示例:";
    [self.clExampleLabel setFont:[UIFont systemFontOfSize:10.0]];
    [self.clExampleLabel setBackgroundColor:[UIColor clearColor]];
    [self.clExampleLabel setTextColor:[UIColor whiteColor]];
    [self.clExampleLabel sizeToFit];
    
    self.clExampleTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 305, 300, 100)];
    self.clExampleTextView.delegate=self;
    self.clExampleTextView.layer.cornerRadius=5;
    self.clExampleTextView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
    self.clExampleTextView.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
//    [self.view addSubview:self.clExampleTextView];
    
    [self.screenView addSubview:titleView];
    [self.screenView addSubview:classView];
    [self.screenView addSubview:self.clUsageLabel];
    [self.screenView addSubview:self.clUsageTextView];
    [self.screenView addSubview:self.clExplainLabel];
    [self.screenView addSubview:self.clExplainTextView];
    [self.screenView addSubview:self.clExampleLabel];
    [self.screenView addSubview:self.clExampleTextView];

    [self.view addSubview:self.screenView];
    
    if (self.isFirst) {
        [self.clTitleTextField becomeFirstResponder];
    }else{
        NSArray *array = [self.dataWorker selectCatalogue:self.PLID :self.CatalogueID];
        self.clTitleTextField.text = [[array objectAtIndex:0] objectAtIndex:0];
        self.clClassTextField.text = [[array objectAtIndex:0] objectAtIndex:1];
        self.clExplainTextView.text = [[array objectAtIndex:0] objectAtIndex:2];
        self.clExampleTextView.text = [[array objectAtIndex:0] objectAtIndex:3];
        self.clUsageTextView.text = [[array objectAtIndex:0] objectAtIndex:4];
    }
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelEdit:)];
    [self.screenView addGestureRecognizer:tap];
    
}

-(void)cancelEdit:(id)sender
{
    


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.clUsageTextView becomeFirstResponder];
    return NO;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView==self.clExplainTextView) {
        CGRect rect1=self.screenView.frame;
        rect1.origin.y-=80;
        [self.screenView setFrame:rect1];
    }else if (textView==self.clExampleTextView){
        CGRect rect2=self.screenView.frame;
        rect2.origin.y-=180;
        [self.screenView setFrame:rect2];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView==self.clExplainTextView) {
        CGRect rect1=self.screenView.frame;
        rect1.origin.y+=80;
        [self.screenView setFrame:rect1];
    }else if (textView==self.clExampleTextView){
        CGRect rect2=self.screenView.frame;
        rect2.origin.y+=180;
        [self.screenView setFrame:rect2];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.isDisappear) {
        [self insertData];
    }
}

- (void)insertData
{
    int ID ;
    if (self.isFirst) {
        if ([self.clTitleTextField.text length]||[self.clClassTextField.text length]||[self.clUsageTextView.text length]||[self.clExplainTextView.text length]||[self.clExampleTextView.text length]) {
            NSArray *array = [self.dataWorker selectCatalogueTitle:self.PLID];
            if ([array count]) {
                ID = [[[array lastObject]objectAtIndex:2]intValue]+1;
                [self.dataWorker insertCatalogueTitle:self.clTitleTextField.text catalogueClass:self.clClassTextField.text catalogueUsage:self.clUsageTextView.text catalogueExplain:self.clExplainTextView.text catalogueExample:self.clExampleTextView.text catalogueID:ID cataloguePLID:self.PLID];
            }else{
                ID = 0;
                [self.dataWorker insertCatalogueTitle:self.clTitleTextField.text catalogueClass:self.clClassTextField.text catalogueUsage:self.clUsageTextView.text catalogueExplain:self.clExplainTextView.text catalogueExample:self.clExampleTextView.text catalogueID:ID cataloguePLID:self.PLID];
            }
        }else
            return;
        
    }else{
        if ([self.clTitleTextField.text length]||[self.clClassTextField.text length]||[self.clUsageTextView.text length]||[self.clExplainTextView.text length]||[self.clExampleTextView.text length]){
            
            [self.dataWorker updateCatalogueTitle:self.clTitleTextField.text catalogueClass:self.clClassTextField.text catalogueUsage:self.clUsageTextView.text catalogueExplain:self.clExplainTextView.text catalogueExample:self.clExampleTextView.text atCatalogueID:self.CatalogueID atCataloguePLID:self.PLID];
            
        }else{
            
            [self.dataWorker deleteFromCatalogueTable:self.PLID :self.CatalogueID];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
