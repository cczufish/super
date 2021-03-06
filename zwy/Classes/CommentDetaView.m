//
//  CommentDetaView.m
//  zwy
//
//  Created by cqsxit on 13-12-16.
//  Copyright (c) 2013年 sxit. All rights reserved.
//

#import "CommentDetaView.h"
#import "CommentDetaController.h"
@interface CommentDetaView ()

@end

@implementation CommentDetaView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if (self) {
        CommentDetaController *detaController =[CommentDetaController new];
        detaController.comDetaView=self;
        self.controller=detaController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*标题背景*/
    float layerHeight=64;
    CALayer *_layerTitleBackView =[CALayer layer];
    _layerTitleBackView.bounds=CGRectMake(0, 0,ScreenWidth , layerHeight);
    CGColorRef layerBorderColor =[[UIColor colorWithRed:0.34 green:0.76 blue:0.91 alpha:1.0] CGColor];
    _layerTitleBackView.backgroundColor=layerBorderColor;
    _layerTitleBackView.anchorPoint=CGPointMake(0, 0);
    _layerTitleBackView.zPosition =-1;
    [self.view.layer addSublayer:_layerTitleBackView];
    
    CALayer *layerSeg=[CALayer layer];
    layerSeg.frame=CGRectMake(-ScreenWidth/2, layerHeight-0.5,ScreenWidth , 0.5);
    layerBorderColor =[[UIColor grayColor] CGColor];
    layerSeg.backgroundColor=layerBorderColor;
    layerSeg.anchorPoint=CGPointMake(0, 0);
    [self.view.layer addSublayer:layerSeg];
    
    
    [_btnBack addTarget:self.controller action:@selector(btnBack) forControlEvents:UIControlEventTouchUpInside];
    [_btnSend addTarget:self.controller action:@selector(btnSend) forControlEvents:UIControlEventTouchUpInside];
    
    _textContent =[[UITextView alloc] initWithFrame:CGRectMake(10, topLayout+10, 300, ScreenHeight-216-topLayout-20)];
    _textContent.delegate=self.controller;
    _textContent.text=@"请输入内容";
    _textContent.font =[UIFont systemFontOfSize:16];
    _textContent.textColor=[UIColor grayColor];
    [self.view addSubview:_textContent];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateToCommentListView{}
@end
