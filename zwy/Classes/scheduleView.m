//
//  scheduleView.m
//  zwy
//
//  Created by cqsxit on 13-11-18.
//  Copyright (c) 2013年 sxit. All rights reserved.
//

#import "scheduleView.h"
#import "ScheduleController.h"

@interface scheduleView ()

@end

@implementation scheduleView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if (self) {
        ScheduleController *schedControl =[ScheduleController new];
        schedControl.schedView=self;
        self.controller=schedControl;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        [_segControl addTarget:self.controller action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    int height =topLayout+80+40;
    _tableViewAll =[[PullRefreshTableView alloc] initWithFrame:CGRectMake(0,height, ScreenWidth, ScreenHeight-height) withDelegate:self.controller];//所有日程
    _tableViewAll.tag=0;
    _tableViewAll.separatorStyle = NO;
    [self.view addSubview:_tableViewAll];
    [_tableViewAll LoadDataBegin];/*刷新数据*/
    
    
    _tableViewWork =[[PullRefreshTableView alloc] initWithFrame:CGRectMake(0,height, ScreenWidth, ScreenHeight-height) withDelegate:self.controller];//工作日程
    _tableViewWork.tag=1;
    _tableViewWork.separatorStyle = NO;
    _tableViewWork.hidden=YES;
    [self.view addSubview:_tableViewWork];
    
    
    _tableViewLife=[[PullRefreshTableView alloc] initWithFrame:CGRectMake(0,height, ScreenWidth, ScreenHeight-height) withDelegate:self.controller];//生活日程
    _tableViewLife.tag=2;
    _tableViewLife.separatorStyle = NO;
    _tableViewLife.hidden=YES;
    [self.view addSubview:_tableViewLife];
    
    
    _tableViewBirthday=[[PullRefreshTableView alloc] initWithFrame:CGRectMake(0,height, ScreenWidth, ScreenHeight-height) withDelegate:self.controller];//生日日程
    _tableViewBirthday.tag=3;
    _tableViewBirthday.separatorStyle = NO;
     _tableViewBirthday.hidden=YES;
    [self.view addSubview:_tableViewBirthday];
    
    
    _tableViewHoliday =[[PullRefreshTableView alloc] initWithFrame:CGRectMake(0,height, ScreenWidth, ScreenHeight-height) withDelegate:self.controller];//节日日程
    _tableViewHoliday.tag=4;
    _tableViewHoliday.separatorStyle = NO;
    _tableViewHoliday.hidden=YES;
    [self.view addSubview:_tableViewHoliday];
    
    /*CGRectMake(ScreenWidth-120, 90, 100, 25)*/
     _labelDays = [[DetailTextView alloc]initWithFrame:self.view.frame];
    [_labelDays setText:@"还有11天"
               WithFont:[UIFont systemFontOfSize:20]
               AndColor:[UIColor whiteColor]];
    [_labelDays setKeyWordTextArray:[NSArray arrayWithObjects:@"1",@"1", nil]
                           WithFont:[UIFont fontWithName:@"AcademyEngravedLetPlain" size:25]
                           AndColor:[UIColor greenColor]];
    [self.view addSubview:_labelDays];
}

-(void)segmentAction:(UISegmentedControl *)Seg{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end