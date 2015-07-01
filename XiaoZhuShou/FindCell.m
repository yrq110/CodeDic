//
//  FindCell.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-21.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "FindCell.h"
@implementation FindCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.PLTitle=[[UILabel alloc]init];
        self.CatalogueClass=[[UILabel alloc]init];
        self.CatalogueTitle=[[UILabel alloc]init];
        self.CatalogueExplain=[[UILabel alloc]init];
        
        self.PLTitle.frame=CGRectMake(5, 10, 34, 34);
        self.PLTitle.backgroundColor=[UIColor colorWithRed:0.94 green:0.17 blue:0 alpha:1];
        self.PLTitle.textColor=[UIColor whiteColor];
        self.PLTitle.layer.cornerRadius=4.0;
        
        self.CatalogueClass.frame=CGRectMake(45, 10, 80, 34);
        self.CatalogueClass.backgroundColor=[UIColor colorWithRed:0.08 green:0.15 blue:0.67 alpha:1];
        self.CatalogueClass.textColor=[UIColor whiteColor];
        self.CatalogueClass.layer.cornerRadius=4.0;
        
        self.CatalogueTitle.frame=CGRectMake(130, 10, 80, 34);
        self.CatalogueTitle.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        self.CatalogueTitle.layer.cornerRadius=4.0;
        
        self.CatalogueExplain.frame=CGRectMake(220, 10, 80, 34);
        self.CatalogueExplain.backgroundColor=[UIColor clearColor];
        self.CatalogueExplain.layer.cornerRadius=4.0;
        
        [self addSubview:self.PLTitle];
        [self addSubview:self.CatalogueClass];
        [self addSubview:self.CatalogueTitle];
        [self addSubview:self.CatalogueExplain];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
