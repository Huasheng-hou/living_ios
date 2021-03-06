//
//  LMActivityDetailController.h
//  living
//
//  Created by Ding on 16/9/30.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "FitBaseViewController.h"
#import "LMActivityHeaderView.h"

@interface LMActivityDetailController : FitBaseViewController
<
LMActivityHeaderViewDelegate
>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic, strong) NSString *titleStr;
@property(nonatomic, strong) NSString *eventUuid;
@property (nonatomic, copy) NSString * type;

// 带tab, nav, status的y向缩放
@property (nonatomic) CGFloat yScaleWithAll;

// 不带tab的y向缩放
@property (nonatomic) CGFloat yScaleNoTab;

// 不带tab, nav的y向缩放
@property (nonatomic) CGFloat yScaleWithStatus;

// x向缩放
@property (nonatomic) CGFloat xScale;
@property (nonatomic) CGFloat yScale;

@end
