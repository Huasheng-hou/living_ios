//
//  LMActivityApplyCell.m
//  living
//
//  Created by WangShengquan on 2017/2/22.
//  Copyright © 2017年 chenle. All rights reserved.
//

#import "LMActivityApplyCell.h"
#import "FitConsts.h"
#import "UIImageView+WebCache.h"

@interface LMActivityApplyCell ()

@property (nonatomic, strong) UIImageView * bKGImageView; // 背景图片
@property (nonatomic, strong) UILabel * titleLbl; // 主标题
@property (nonatomic, strong) UILabel * detailLbl;  // 副标题
@property (nonatomic, strong) UILabel *joinedLbl;  // 参加人数
@property (nonatomic, strong) UILabel *remainderNum; // 剩余名额
@property (nonatomic, strong) UILabel *costNum;  // 费用


@end

@implementation LMActivityApplyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout
{
    self.backgroundColor = [UIColor whiteColor];
    
    _bKGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 185)];
    _bKGImageView.backgroundColor = [UIColor grayColor];
    //_bKGImageView.image = [UIImage imageNamed:@"BackImage"];
    [self.contentView addSubview:_bKGImageView];
    
    _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 23)];
    _titleLbl.text = @"情人节单身派对";
    _titleLbl.font = TEXT_FONT_LEVEL_1;
    _titleLbl.textColor = [UIColor whiteColor];
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLbl];
    
    _detailLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 87, kScreenWidth, 14)];
    _detailLbl.text = @"杭州V5生活馆   截止至3月31日";
    _detailLbl.font = TEXT_FONT_LEVEL_3;
    _detailLbl.textColor = [UIColor whiteColor];
    _detailLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_detailLbl];
    
    _joinBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 47, 108, 94, 23)];
    [_joinBtn setTitle:@"约起来" forState:UIControlStateNormal];
    _joinBtn.titleLabel.font = TEXT_FONT_LEVEL_2;
    [_joinBtn setBackgroundColor:[UIColor orangeColor]];
    _joinBtn.layer.cornerRadius = 3;
//    [_joinBtn addTarget:self action:@selector(joinBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_joinBtn];
    
    _costNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80, 195, 70, 20)];
    _costNum.text = @"费用 ¥100";
    _costNum.font = TEXT_FONT_LEVEL_3;
    _costNum.textColor = TEXT_COLOR_LEVEL_4;
    _costNum.textAlignment = NSTextAlignmentCenter;
    _costNum.layer.cornerRadius = 5;
    _costNum.layer.borderWidth = 0.5;
    _costNum.layer.borderColor = TEXT_COLOR_LEVEL_4.CGColor;
    //[self.contentView addSubview:_costNum];
    
    _remainderNum = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 170, 195, 80, 20)];
    _remainderNum.text = @"剩余名额 73";
    _remainderNum.font = TEXT_FONT_LEVEL_3;
    _remainderNum.textColor = TEXT_COLOR_LEVEL_4;
    _remainderNum.textAlignment = NSTextAlignmentCenter;
    _remainderNum.layer.cornerRadius = 5;
    _remainderNum.layer.borderWidth = 0.5;
    _remainderNum.layer.borderColor = TEXT_COLOR_LEVEL_4.CGColor;
    //[self.contentView addSubview:_remainderNum];
    
    _joinedLbl = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 280, 195, 100, 20)];
    _joinedLbl.text = @"7/80已报名参加";
    _joinedLbl.font = TEXT_FONT_LEVEL_3;
    _joinedLbl.textColor = TEXT_COLOR_LEVEL_4;
    _joinedLbl.textAlignment = NSTextAlignmentCenter;
    _joinedLbl.layer.cornerRadius = 5;
    _joinedLbl.layer.borderWidth = 0.5;
    _joinedLbl.layer.borderColor = TEXT_COLOR_LEVEL_4.CGColor;
    //[self.contentView addSubview:_joinedLbl];
}

@end
