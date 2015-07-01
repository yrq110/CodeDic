//
//  CustomViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-3.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CustomViewController.h"
#import "MainViewController.h"
#import "CustomCatalogueViewController.h"
@interface CustomViewController ()

@end

@implementation CustomViewController

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
    self.title=@"自定义语言";
    [self initNavBar];
    [self initScrollView];
    [self initData];
    [self initView];
//    [self snowEffect];
    self.colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:0.773830F green:0.767224F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.773830F green:0.873416F blue:0.725974F alpha:0.5F],[UIColor colorWithRed:0.873416F green:0.681577F blue:0.758009F alpha:0.5F],[UIColor whiteColor],[UIColor colorWithRed:0.615054F green:0.798404F blue:0.873416F alpha:0.5F], nil];
}

- (void)initNavBar
{
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backToMenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNote)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:56.0/255.0 green:81.0/255.0 blue:222.0/255.0 alpha:1.0]];
}

- (void)initScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 524)];
    self.scrollView.contentSize = CGSizeMake(320, 524);
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor clearColor];
}

- (void)initData
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
}

- (void)initView
{
    EditView=[[CustomEditView alloc]initWithFrame:CGRectMake(10, 60, 300, 170)];
    EditView.layer.masksToBounds = YES;
    EditView.layer.cornerRadius = 5.0;
    EditView.layer.borderWidth = 3.0;
    EditView.layer.borderColor = [[UIColor blueColor]CGColor];
    [EditView editview];
    EditView.editdelegate = self;
}

-(void)snowEffect
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
	snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, 0);
	snowEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width * 2.0,0);
	
	// Spawn points for the flakes are within on the outline of the line
	snowEmitter.emitterMode		= kCAEmitterLayerOutline;
	snowEmitter.emitterShape	= kCAEmitterLayerLine;
	
	// Configure the snowflake emitter cell
	CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
	
	snowflake.birthRate		= 1.0;
	snowflake.lifetime		= 120.0;
	
	snowflake.velocity		= -10;				// falling down slowly
	snowflake.velocityRange = 10;
	snowflake.yAcceleration = 2;
	snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
	snowflake.spinRange		= 0.25 * M_PI;		// slow spin
	
	snowflake.contents		= (id) [[UIImage imageNamed:@"DazFlake.png"] CGImage];
	snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
	// Make the flakes seem inset in the background
	snowEmitter.shadowOpacity = 1.0;
	snowEmitter.shadowRadius  = 0.0;
	snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
	snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
	
	// Add everything to our backing layer below the UIContol defined in the storyboard
	snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
//    NSLog(@"snow");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self printNoteBookIndex];
}

- (void)printNoteBookIndex
{
    
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake(320, 416);
    
    NSMutableArray *array = [self.dataWorker selectPLData];
    for (int i = 8; i < [array count]; i++) {
        CustomIndexView *codeIndex = [[CustomIndexView alloc] initWithFrame:CGRectMake(0, 3 + (i-8)*51, 320, 46)];
        codeIndex.delegate = self;
        codeIndex.titleLabel.text = [[array objectAtIndex:i] objectAtIndex:0];
        codeIndex.timeLabel.text = @"";
        codeIndex.ID = [[[array objectAtIndex:i] objectAtIndex:1] intValue];
        [self.scrollView addSubview:codeIndex];
        codeIndex.backgroundView.backgroundColor = [self.colorArray objectAtIndex:(i-8)%5];
        if ((i-8)>7) {
            self.scrollView.contentSize = CGSizeMake(320, 90+(i-8)*51);
        }
    }
//    [self snowEffect];
}



- (void)backToMenu
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        MainVC.ConVC.isBeginCustom=NO;
        NSLog(@"No is %d",MainVC.submenuVC.SelectNo);
        [MainVC.ddMenu showLeftController:NO];
    }];
    
}


- (void)createNote
{
    [self.backView removeFromSuperview];
    [EditView.edit becomeFirstResponder];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.7;
    [self.view addSubview:self.backView];
    EditView.edit.text = @"";
    [self.view addSubview:EditView];
}


- (void)cancel
{
    [self.backView removeFromSuperview];
}


- (void) withMessage:(NSString *)message
{
    [self.backView removeFromSuperview];
 
    NSArray *array = [self.dataWorker selectPLData];
    int ID ;
    if ([array count]) {
        ID = [[[array objectAtIndex:[array count]-1]objectAtIndex:1]intValue]+1;
        [self.dataWorker insertPLTitle:message andPLID:ID];
    }else{
        ID = 0;
        [self.dataWorker insertPLTitle:message andPLID:ID];
    }
    
    [self printNoteBookIndex];
}


- (void)noteDidDelete:(CustomIndexView *)note
{
    NSMutableArray *array = [self.dataWorker selectPLData];
    
    if (note.ID<([array count]-1)) {
        [self.dataWorker deleteFromPLTable:note.ID];
        [self.dataWorker deleteAllFromCatalogueTable:note.ID];
        for (int i=note.ID; i<[array count]-1; i++) {
                NSString *str=[[[self.dataWorker selectPLTitle:i+1]objectAtIndex:0]objectAtIndex:0];
                [self.dataWorker updatePLID:i atTitle:str];
            NSMutableArray *arrCL=[self.dataWorker selectCatalogueTitle:i+1];
            for (int j=0; j<[arrCL count]; j++) {
                NSString *str2=[[[self.dataWorker selectCatalogueTitle:i+1]objectAtIndex:j]objectAtIndex:0];
                [self.dataWorker updateCataloguePLID:i atCatalogueTitle:str2];
            }
            
        }
    }else{
        [self.dataWorker deleteFromPLTable:note.ID];
        [self.dataWorker deleteAllFromCatalogueTable:note.ID];
        
    }
    [self printNoteBookIndex];
}


-(void)noteDidSelect:(CustomIndexView *)note
{
    CustomCatalogueViewController *ccVC = [[CustomCatalogueViewController alloc] init];
    ccVC.PLID = note.ID;
    NSArray *array=[self.dataWorker selectPLTitle:note.ID];
    ccVC.title = [[array objectAtIndex:0]objectAtIndex:0];
    [self.navigationController pushViewController:ccVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
