//
//  CustomEditView.m
//  XiaoZhuShou
//
//  Created by yrq on 15-4-3.
//  Copyright (c) 2015年 yrq. All rights reserved.
//

#import "CustomEditView.h"

@implementation CustomEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    self.editdelegate = nil;
}


-(void)editview
{
    self.backgroundColor=[UIColor whiteColor];
    self.cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setFrame:CGRectMake(200, 5, 100, 30)];
    self.cancel.backgroundColor=[UIColor redColor];
    self.cancel.tintColor=nil;
    [self.cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancel];
    self.cancelLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 100, 30)];
    self.cancelLabel.text=@"取消";
    self.cancelLabel.font=[UIFont boldSystemFontOfSize:16.0];
    self.cancelLabel.textAlignment=1;
    self.cancelLabel.textColor=[UIColor redColor];
    [self addSubview:self.cancelLabel];
    
    
    self.save=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.save setFrame:CGRectMake(0, 5, 100, 30)];
    self.save.backgroundColor=[UIColor clearColor];
    self.save.tintColor=nil;
    [self.save addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.save];
    self.saveLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 30)];
    self.saveLabel.text=@"保存";
    self.saveLabel.font=[UIFont boldSystemFontOfSize:16.0];
    self.saveLabel.textAlignment=1;
    self.saveLabel.textColor=[UIColor blueColor];
    [self addSubview:self.saveLabel];
    
    
    self.line=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 300, 3)];
    self.line.backgroundColor=[UIColor blueColor];
    [self addSubview:self.line];
    
    self.line2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 300, 3)];
    self.line2.backgroundColor=[UIColor blueColor];
    [self addSubview:self.line2];
    
    self.edit=[[UITextView alloc]initWithFrame:CGRectMake(0, 45, 300, 120)];
    [self addSubview:self.edit];
    
}
- (void)cancel:(id)sender
{
    [self removeFromSuperview];
    if ([self.editdelegate respondsToSelector:@selector(cancel)]) {
        [self.editdelegate cancel];
    }
}

- (void)done:(id)sender
{
    if ([self.editdelegate respondsToSelector:@selector(withMessage:)]){
        [self.editdelegate  withMessage:self.edit.text];
    }
    [self removeFromSuperview];
}

@end
