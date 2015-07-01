//
//  FindViewController.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-20.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "FindViewController.h"
#import "MainViewController.h"
#import "FindCell.h"
@interface FindViewController ()

@end

@implementation FindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        self.data = [NSArray arrayWithObjects:@"Allan",@"Abbbb",@"Acccc",@"Bccccc",@"Cddddffk",@"Cddkllll",@"Ekkflfl",@"Ekljljfg" ,@"Leslie",@"Mm",@"Meinv",@"Meihi",@"Catilin",@"Arron", nil];
        
    }
    return self;
}
bool isFirst=YES;
int num=0,preNum=0,i=1,first=0;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createSQL];
    
    NSMutableArray *array=[self.dataWorker selectCatalogueData];
    self.arrPLID=[NSMutableArray arrayWithCapacity:0];
    self.arrPLTitle=[NSMutableArray arrayWithCapacity:0];
    self.arrCatalogueClass=[NSMutableArray arrayWithCapacity:0];
    self.arrCatalogueTitle=[NSMutableArray arrayWithCapacity:0];
    self.arrCatalogueExplain=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<[array count]; i++) {
        [self.arrPLID addObject:[[array objectAtIndex:i]objectAtIndex:5]];
        [self.arrCatalogueClass addObject:[[array objectAtIndex:i]objectAtIndex:1]];
        [self.arrCatalogueTitle addObject:[[array objectAtIndex:i]objectAtIndex:0]];
        [self.arrCatalogueExplain addObject:[[array objectAtIndex:i]objectAtIndex:3]];
//        NSLog(@"%@",[self.arrTag objectAtIndex:i]);
    }
    for (int j=0; j<[self.arrPLID count]; j++) {
        NSArray *arr=[self.dataWorker selectPLData];
        int a=[[self.arrPLID objectAtIndex:j]intValue];
        NSString *str=[[arr objectAtIndex:a]objectAtIndex:0];
//        NSLog(@"%d is %@",j+1,str);
        [self.arrPLTitle addObject:str];
    }
    self.PLIDArr=[NSMutableArray arrayWithCapacity:0];
    self.CatalogueArr=[NSMutableArray arrayWithCapacity:0];
    self.data=[NSMutableArray arrayWithCapacity:0];
    self.data=[NSMutableArray arrayWithArray:self.arrCatalogueTitle];
    [self initView];
    

}

- (void)createSQL
{
    self.dataWorker = [[CodeSQL alloc] init];
    [self.dataWorker createDB];
    
}

-(void)initView
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width-60, 44)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate=self;
    [self.searchBar sizeToFit];
    [self.view addSubview:self.searchBar];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView setContentSize:CGSizeMake(320, 3000)];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource=self;
    self.searchController.searchResultsDelegate=self;
    self.searchController.delegate=self;

    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [topView setBackgroundColor:[UIColor colorWithRed:0.15 green:0.6 blue:0.88 alpha:1]];
    [self.view addSubview:topView];
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setFrame:CGRectMake(10, 0, 44, 44)];
    [back addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:back];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(135, 0, 50, 44)];
    label.text=@"搜索";
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor clearColor];
    [topView addSubview:label];
    
    
    self.tableView.bounces=NO;
    self.searchController.searchResultsTableView.bounces=NO;
    [self setExtraCellLineHidden:self.tableView];
    [self setExtraCellLineHidden:self.searchController.searchResultsTableView];
    
}


-(void)backView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        MainViewController *MainVC=(MainViewController*)[MainViewController shareMainViewController];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        [MainVC.ddMenu showLeftController:NO];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView) {
        return self.data.count;
    }else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",self.searchController.searchBar.text];
        self.filterCatalogueClass =  [[NSMutableArray alloc] initWithArray:[self.arrCatalogueClass filteredArrayUsingPredicate:predicate]];
        self.filterCatalogueTitle =  [[NSMutableArray alloc] initWithArray:[self.arrCatalogueTitle filteredArrayUsingPredicate:predicate]];
        self.filterCatalogueExplain =  [[NSMutableArray alloc] initWithArray:[self.arrCatalogueExplain filteredArrayUsingPredicate:predicate]];
        if([self.filterCatalogueClass count]!=0){
            return [self.filterCatalogueClass count];
        }else if([self.filterCatalogueTitle count]!=0){
            return [self.filterCatalogueTitle count];
        }else if([self.filterCatalogueExplain count]!=0){
            return [self.filterCatalogueExplain count];
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    FindCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell=[[FindCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    if (tableView==self.tableView){
        NSArray *arr=[self.dataWorker selectPLData];
        int a=[[self.arrPLID objectAtIndex:indexPath.row]intValue];
        NSString *str=[[arr objectAtIndex:a]objectAtIndex:0];
        cell.PLTitle.text=str;
        [self sizeToFit:cell.PLTitle];
        
        cell.CatalogueClass.text=[self.arrCatalogueClass objectAtIndex:indexPath.row];
        [self sizeToFit:cell.CatalogueClass];
        [self moveLabelX:cell.CatalogueClass :cell.PLTitle];
        
        cell.CatalogueTitle.text=[self.arrCatalogueTitle objectAtIndex:indexPath.row];
        [self sizeToFit:cell.CatalogueTitle];
        [self moveLabelX:cell.CatalogueTitle :cell.CatalogueClass];
        
        cell.CatalogueExplain.text=[self.arrCatalogueExplain objectAtIndex:indexPath.row];
        [self sizeToFit:cell.CatalogueExplain];
        CGRect rect3=cell.CatalogueExplain.frame;
        rect3.origin.x=cell.CatalogueTitle.frame.origin.x+cell.CatalogueTitle.frame.size.width+10;
        if ((rect3.size.width+rect3.origin.x)>310) {
            rect3.size.width=310-rect3.origin.x;
        }
        cell.CatalogueExplain.frame=rect3;
        
        [self.PLIDArr insertObject:[self.arrPLID objectAtIndex:indexPath.row] atIndex:indexPath.row];
        [self.CatalogueArr insertObject:[[[self.dataWorker selectCatalogueID:cell.CatalogueTitle.text]objectAtIndex:0]objectAtIndex:0] atIndex:indexPath.row];
        
        
    }else{
        if ([self.filterCatalogueClass count]!=0) {
            NSArray *arr2=[self.dataWorker selectCatalogueTitleAndExplain:[self.filterCatalogueClass objectAtIndex:0]];
            NSArray *arr=[self.dataWorker selectPLData];
            int a=[[[arr2 objectAtIndex:indexPath.row]objectAtIndex:2]intValue];
            NSString *str=[[arr objectAtIndex:a]objectAtIndex:0];
            cell.PLTitle.text=str;
            [self sizeToFit:cell.PLTitle];
            
            cell.CatalogueClass.text=[self.filterCatalogueClass objectAtIndex:0];
            [self sizeToFit:cell.CatalogueClass];
            [self moveLabelX:cell.CatalogueClass :cell.PLTitle];
            
            cell.CatalogueTitle.text=[[arr2 objectAtIndex:indexPath.row]objectAtIndex:0];
            [self sizeToFit:cell.CatalogueTitle];
            [self moveLabelX:cell.CatalogueTitle :cell.CatalogueClass];
            
            cell.CatalogueExplain.text=[[arr2 objectAtIndex:indexPath.row]objectAtIndex:1];
            [self sizeToFit:cell.CatalogueExplain];
            CGRect rect3=cell.CatalogueExplain.frame;
            rect3.origin.x=cell.CatalogueTitle.frame.origin.x+cell.CatalogueTitle.frame.size.width+10;
            if ((rect3.size.width+rect3.origin.x)>310) {
                rect3.size.width=310-rect3.origin.x;
            }
            cell.CatalogueExplain.frame=rect3;
            
            
        }else if([self.filterCatalogueTitle count]!=0){
            NSMutableArray *arr3=[self arrayWithMemberIsOnly:self.filterCatalogueTitle];
            if (isFirst==YES) {
                self.filterEchoTitle=[NSArray array];
                self.filterEchoTitle=[self.dataWorker selectCatalogueClassAndExplain:[arr3 objectAtIndex:0]];
                num=[self.filterEchoTitle count];
                isFirst=NO;
            }
            if((indexPath.row>num-1)&&((indexPath.row-preNum)>([self.filterEchoTitle count]-1))) {
                self.filterEchoTitle=[NSArray arrayWithArray:[self.dataWorker selectCatalogueClassAndExplain:[arr3 objectAtIndex:i]]];
                i++;
                preNum=num;
                num+=[self.filterEchoTitle count];
//                NSLog(@"i,pre,num is %d,%d,%d",i,preNum,num);
            }
            NSArray *arr=[self.dataWorker selectPLData];
            int a=[[[self.filterEchoTitle objectAtIndex:indexPath.row-preNum]objectAtIndex:2]intValue];
            NSString *str=[[arr objectAtIndex:a]objectAtIndex:0];
            cell.PLTitle.text=str;
            [self sizeToFit:cell.PLTitle];
            
            cell.CatalogueClass.text=[[self.filterEchoTitle objectAtIndex:indexPath.row-preNum]objectAtIndex:0];
            [self sizeToFit:cell.CatalogueClass];
            [self moveLabelX:cell.CatalogueClass :cell.PLTitle];
            
            cell.CatalogueTitle.text=[[self.filterEchoTitle objectAtIndex:indexPath.row-preNum]objectAtIndex:3];
            [self sizeToFit:cell.CatalogueTitle];
            [self moveLabelX:cell.CatalogueTitle :cell.CatalogueClass];
            
            cell.CatalogueExplain.text=[[self.filterEchoTitle objectAtIndex:indexPath.row-preNum]objectAtIndex:1];
            [self sizeToFit:cell.CatalogueExplain];
            CGRect rect3=cell.CatalogueExplain.frame;
            rect3.origin.x=cell.CatalogueTitle.frame.origin.x+cell.CatalogueTitle.frame.size.width+10;
            if ((rect3.size.width+rect3.origin.x)>310) {
                rect3.size.width=310-rect3.origin.x;
            }
            cell.CatalogueExplain.frame=rect3;
            
            [self.PLIDArr insertObject:[[self.filterEchoTitle objectAtIndex:indexPath.row-preNum]objectAtIndex:2] atIndex:indexPath.row];
            [self.CatalogueArr insertObject:[[[self.dataWorker selectCatalogueID:cell.CatalogueTitle.text]objectAtIndex:0]objectAtIndex:0] atIndex:indexPath.row];
//            NSLog(@"%@  %@  %d ",[self.PLIDArr objectAtIndex:indexPath.row],[self.CatalogueArr objectAtIndex:indexPath.row],indexPath.row);
            
        }else if ([self.filterCatalogueExplain count]!=0){
            NSMutableArray *arr3=[self arrayWithMemberIsOnly:self.filterCatalogueExplain];
            if (isFirst==YES) {
                self.filterEchoExplain=[NSArray array];
                self.filterEchoExplain=[self.dataWorker selectCatalogueTitleAndClass:[arr3 objectAtIndex:0]];
                num=[self.filterEchoExplain count];
                isFirst=NO;
            }
            if((indexPath.row>num-1)&&((indexPath.row-preNum)>([self.filterEchoExplain count]-1))) {
                self.filterEchoExplain=[NSArray arrayWithArray:[self.dataWorker selectCatalogueTitleAndClass:[arr3 objectAtIndex:i]]];
                i++;
                preNum=num;
                num+=[self.filterEchoExplain count];
//                NSLog(@"i,pre,num is %d,%d,%d",i,preNum,num);
            }
            NSArray *arr=[self.dataWorker selectPLData];
            int a=[[[self.filterEchoExplain objectAtIndex:indexPath.row-preNum]objectAtIndex:2]intValue];
            NSString *str=[[arr objectAtIndex:a]objectAtIndex:0];
            cell.PLTitle.text=str;
            [self sizeToFit:cell.PLTitle];
            
            cell.CatalogueClass.text=[[self.filterEchoExplain objectAtIndex:indexPath.row-preNum]objectAtIndex:1];
            [self sizeToFit:cell.CatalogueClass];
            [self moveLabelX:cell.CatalogueClass :cell.PLTitle];
            
            cell.CatalogueTitle.text=[[self.filterEchoExplain objectAtIndex:indexPath.row-preNum]objectAtIndex:0];
            [self sizeToFit:cell.CatalogueTitle];
            [self moveLabelX:cell.CatalogueTitle :cell.CatalogueClass];
            
            cell.CatalogueExplain.text=[[self.filterEchoExplain objectAtIndex:indexPath.row-preNum]objectAtIndex:3];
            [self sizeToFit:cell.CatalogueExplain];
            CGRect rect3=cell.CatalogueExplain.frame;
            rect3.origin.x=cell.CatalogueTitle.frame.origin.x+cell.CatalogueTitle.frame.size.width+10;
            if ((rect3.size.width+rect3.origin.x)>310) {
                rect3.size.width=310-rect3.origin.x;
            }
            cell.CatalogueExplain.frame=rect3;
            [self.PLIDArr insertObject:[[self.filterEchoExplain objectAtIndex:indexPath.row-preNum]objectAtIndex:2] atIndex:indexPath.row];
            [self.CatalogueArr insertObject:[[[self.dataWorker selectCatalogueID:cell.CatalogueTitle.text]objectAtIndex:0]objectAtIndex:0] atIndex:indexPath.row];
//            NSLog(@"%@  %@  %d ",[self.PLIDArr objectAtIndex:indexPath.row],[self.CatalogueArr objectAtIndex:indexPath.row],indexPath.row);
        }
    }
    return cell;
}


-(void)sizeToFit:(UILabel*)label
{
    UIFont *font=[UIFont systemFontOfSize:10.0];
    CGSize size = [label.text sizeWithFont:font constrainedToSize:CGSizeMake(280,34) lineBreakMode:NSLineBreakByWordWrapping];
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

-(NSMutableArray *)arrayWithMemberIsOnly:(NSMutableArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        @autoreleasepool {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO) {
                [categoryArray addObject:[array objectAtIndex:i]];
                }
        }
    }
    return categoryArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text;
    if (tableView == self.tableView) {
//        text = self.data[indexPath.row];
        MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
        [MainVC.ConVC PLNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.submenuVC PLNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ConVC CaNo:[[self.CatalogueArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ConVC NoteNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue] :[[self.CatalogueArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ddMenu showRootController:NO];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
//        text = self.filterData[indexPath.row];
        NSLog(@"%@  %@  %d ",[self.PLIDArr objectAtIndex:indexPath.row],[self.CatalogueArr objectAtIndex:indexPath.row],indexPath.row);
        MainViewController *MainVC=(MainViewController *)[MainViewController shareMainViewController];
        [MainVC.ConVC PLNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.submenuVC PLNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ConVC CaNo:[[self.CatalogueArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ConVC NoteNo:[[self.PLIDArr objectAtIndex:indexPath.row]intValue] :[[self.CatalogueArr objectAtIndex:indexPath.row]intValue]];
        [MainVC.ddMenu showRootController:NO];
        MainVC.ddMenu.rootViewController.view.alpha=1;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
//    NSLog(@"you click %d   %@",indexPath.row,text);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    num=0,preNum=0,i=1,isFirst=YES;
    [self.tableView reloadData];

}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [view release];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    return YES;


}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
