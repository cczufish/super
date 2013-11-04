//
//  MeettingView.m
//  zwy
//
//  Created by wangshuang on 10/12/13.
//  Copyright (c) 2013 sxit. All rights reserved.
//

#import "MeettingView.h"
#import "MeettingController.h"
@interface MeettingView ()

@end

@implementation MeettingView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        MeettingController *meetting=[MeettingController new];
        meetting.meettingView=self;
        self.controller=meetting;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //初使化数据
    [_btnCheck addTarget:self.controller action:@selector(btnCheck) forControlEvents:UIControlEventTouchUpInside];
    _btnCheck.layer.masksToBounds = YES;
    _btnCheck.layer.cornerRadius = 5.0;
    
    [_btnAddpeople addTarget:self.controller action:@selector(btnAddpeople) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnDate addTarget:self.controller action:@selector(btnDate) forControlEvents:UIControlEventTouchUpInside];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * dateText = [formatter stringFromDate:[NSDate date]];
    [_btnDate setTitle:dateText forState:UIControlStateNormal];
    _btnDate.hidden=YES;
    
    [_btnTime addTarget:self.controller action:@selector(btnTime) forControlEvents:UIControlEventTouchUpInside];
    NSDateFormatter *formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:@"HH:mm"];
    NSString * timeText = [formatterTime stringFromDate:[NSDate date]];
    [_btnTime setTitle:timeText forState:UIControlStateNormal];
    _btnTime.hidden=YES;
    
    
    [_segControl addTarget:self.controller action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    _tableViewPeople.delegate=self.controller;
    _tableViewPeople.dataSource=self.controller;
    
    _meetting_date.hidden=YES;
    _meetting_time.hidden=YES;
    _btnTime.hidden=YES;
    _btnDate.hidden=YES;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString * dateText1 = [formatter1 stringFromDate:[NSDate date]];
    _atonce_time.text=dateText1;
    
    _nsTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
     
}

-(void)scrollTimer{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString * dateText = [formatter stringFromDate:[NSDate date]];
    _atonce_time.text=dateText;
}


- (void)segmentAction:(id)sender{
    
}

- (void)dateChanged{

}


- (void)viewDidAppear:(BOOL)animated{

}



- (void)viewDidLayoutSubviews{

}


- (void)viewWillLayoutSubviews{


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
