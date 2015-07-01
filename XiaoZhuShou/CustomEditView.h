//
//  CustomEditView.h
//  XiaoZhuShou
//
//  Created by yrq on 15-4-3.
//  Copyright (c) 2015年 yrq. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol CustomEditViewDelegate <NSObject>

- (void) withMessage:(NSString *) message;
- (void) cancel;

@end

@interface CustomEditView : UIView
@property (strong, nonatomic) UITextView *edit;
@property (strong, nonatomic) UIButton *cancel;
@property (strong, nonatomic) UILabel *cancelLabel;
@property (strong, nonatomic) UIButton *save;
@property (strong, nonatomic) UILabel *saveLabel;
@property (strong, nonatomic) UIImageView *line;
@property (strong, nonatomic) UIImageView *line2;
@property (assign, nonatomic) id<CustomEditViewDelegate> editdelegate;
- (void)editview;
- (void)cancel:(id)sender;
- (void)done:(id)sender;
@end