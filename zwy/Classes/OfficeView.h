//
//  OfficeView.h
//  zwy
//
//  Created by wangshuang on 10/12/13.
//  Copyright (c) 2013 sxit. All rights reserved.
//

#import "BaseView.h"
#import "OfficeView.h"
#import "DocContentInfo.h"
@interface OfficeView : BaseView
@property (strong, nonatomic) IBOutlet UISegmentedControl *selecter;
@property (strong, nonatomic) DocContentInfo *docContentInfo;

- (void)dissmissFromHomeView;
@end
