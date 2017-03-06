//
//  LMPulicVoicemsgViewCell.m
//  living
//
//  Created by Ding on 2016/12/13.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import "LMPulicVoicemsgViewCell.h"
#import "FitConsts.h"
#define titleW titleLable.bounds.size.width

@implementation LMPulicVoicemsgViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self    = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    
    //课程标题
    UILabel *titleLable = [UILabel new];
    titleLable.text = @"课程标题";
    titleLable.font = TEXT_FONT_LEVEL_1;
    titleLable.textColor = TEXT_COLOR_LEVEL_2;
    [titleLable sizeToFit];
    titleLable.frame = CGRectMake(10, 5, titleLable.bounds.size.width, 30);
    [self.contentView addSubview:titleLable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 40, kScreenWidth-30-titleW, 0.5)];
    lineView.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView];
    
    //选择主持
    UILabel *addressLable = [UILabel new];
    addressLable.text = @"选择主持";
    addressLable.font = TEXT_FONT_LEVEL_1;
    addressLable.textColor = TEXT_COLOR_LEVEL_2;
    [addressLable sizeToFit];
    addressLable.frame = CGRectMake(10, 50, addressLable.bounds.size.width, 30);
    [self.contentView addSubview:addressLable];
    
    //联系电话
    UILabel *phoneLable = [UILabel new];
    phoneLable.text = @"联系电话";
    phoneLable.font = TEXT_FONT_LEVEL_1;
    phoneLable.textColor = TEXT_COLOR_LEVEL_2;
    [phoneLable sizeToFit];
    phoneLable.frame = CGRectMake(10, 95, titleW, 30);
    [self.contentView addSubview:phoneLable];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 260, kScreenWidth-30-titleW, 0.5)];
    lineView1.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView1];
    //联系姓名
    UILabel *nameLable = [UILabel new];
    nameLable.text = @"联系姓名";
    nameLable.font = TEXT_FONT_LEVEL_1;
    nameLable.textColor = TEXT_COLOR_LEVEL_2;
    [nameLable sizeToFit];
    nameLable.frame = CGRectMake(10, 140, titleW, 30);
    [self.contentView addSubview:nameLable];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 130, kScreenWidth-30-titleW, 0.5)];
    lineView2.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView2];
    //人均费用
    UILabel *freeLable = [UILabel new];
    freeLable.text = @"课程费用";
    freeLable.font = TEXT_FONT_LEVEL_1;
    freeLable.textColor = TEXT_COLOR_LEVEL_2;
    [freeLable sizeToFit];
    freeLable.frame = CGRectMake(10, 185, titleW, 30);
    [self.contentView addSubview:freeLable];
    
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 175, kScreenWidth-30-titleW, 0.5)];
    lineView8.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView8];
    
    //会员费用
    UILabel *VIPLable = [UILabel new];
    VIPLable.text = @"会员费用";
    VIPLable.font = TEXT_FONT_LEVEL_1;
    VIPLable.textColor = TEXT_COLOR_LEVEL_2;
    [VIPLable sizeToFit];
    VIPLable.frame = CGRectMake(10, 230, titleW, 30);
    [self.contentView addSubview:VIPLable];
    
    UIView *lineView9 = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 220, kScreenWidth-30-titleW, 0.5)];
    lineView9.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView9];
    
    //加盟商费用
    UILabel *couponLable = [UILabel new];
    couponLable.text = @"加盟商价格";
    couponLable.font = TEXT_FONT_LEVEL_1;
    couponLable.textColor = TEXT_COLOR_LEVEL_2;
    [couponLable sizeToFit];
    couponLable.frame = CGRectMake(10, 275, couponLable.bounds.size.width, 30);
    [self.contentView addSubview:couponLable];
    
    UIView *lineView10 = [[UIView alloc] initWithFrame:CGRectMake(20+couponLable.bounds.size.width, 305, kScreenWidth-30-couponLable.bounds.size.width, 0.5)];
    lineView10.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView10];
    
    
    //是否抵用
    UILabel *UseLable = [UILabel new];
    UseLable.text = @"是否抵用";
    UseLable.font = TEXT_FONT_LEVEL_1;
    UseLable.textColor = TEXT_COLOR_LEVEL_2;
    [UseLable sizeToFit];
    UseLable.frame = CGRectMake(10, 320, UseLable.bounds.size.width, 30);
    [self.contentView addSubview:UseLable];
    
    //参加人数
    UILabel *joinLable = [UILabel new];
    joinLable.text = @"课程人数";
    joinLable.font = TEXT_FONT_LEVEL_1;
    joinLable.textColor = TEXT_COLOR_LEVEL_2;
    [joinLable sizeToFit];
    joinLable.frame = CGRectMake(10, 365, titleW, 30);
    [self.contentView addSubview:joinLable];
    
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(20+titleW, 395, kScreenWidth-30-titleW, 0.5)];
    lineView3.backgroundColor = LINE_COLOR;
    [self.contentView addSubview:lineView3];
    //开始时间
    UILabel *startLable = [UILabel new];
    startLable.text = @"开始时间";
    startLable.font = TEXT_FONT_LEVEL_1;
    startLable.textColor = TEXT_COLOR_LEVEL_2;
    [startLable sizeToFit];
    startLable.frame = CGRectMake(10, 410, startLable.bounds.size.width, 30);
    [self.contentView addSubview:startLable];
    
    
    
    //结束时间
    UILabel *stopLable = [UILabel new];
    stopLable.text = @"结束时间";
    stopLable.font = TEXT_FONT_LEVEL_1;
    stopLable.textColor = TEXT_COLOR_LEVEL_2;
    [stopLable sizeToFit];
    stopLable.frame = CGRectMake(10, 455, stopLable.bounds.size.width, 30);
    [self.contentView addSubview:stopLable];

    
    
    //报名须知
    UILabel *msgLabel = [UILabel new];
    msgLabel.text = @"报名须知";
    msgLabel.font = TEXT_FONT_LEVEL_1;
    msgLabel.textColor = TEXT_COLOR_LEVEL_2;
    [msgLabel sizeToFit];
    msgLabel.frame = CGRectMake(10, 500, msgLabel.bounds.size.width, 30);
    [self.contentView addSubview:msgLabel];
    
    
    
    //封面图片
    UILabel *imageLable = [UILabel new];
    imageLable.text = @"封面图片";
    imageLable.font = TEXT_FONT_LEVEL_1;
    imageLable.textColor = TEXT_COLOR_LEVEL_2;
    [imageLable sizeToFit];
    imageLable.frame = CGRectMake(10, 590, imageLable.bounds.size.width, 30);
    [self.contentView addSubview:imageLable];
    
    UILabel *imagemsgLable = [UILabel new];
    imagemsgLable.text = @"(建议尺寸：750*330)";
    imagemsgLable.font = TEXT_FONT_LEVEL_3;
    imagemsgLable.textColor = TEXT_COLOR_LEVEL_3;
    [imagemsgLable sizeToFit];
    imagemsgLable.frame = CGRectMake(15+imageLable.bounds.size.width, 590, imagemsgLable.bounds.size.width, 30);
    [self.contentView addSubview:imagemsgLable];
    
    
    _titleTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 5, kScreenWidth- titleW-30, 30)];
    _titleTF.font = TEXT_FONT_LEVEL_2;
    _titleTF.returnKeyType = UIReturnKeyDone;
    _titleTF.placeholder = @"请输入课程标题";
    [self.contentView addSubview:_titleTF];
    
    
    //课程地址
    
    _hostButton = [LMTimeButton buttonWithType:UIButtonTypeSystem];
    _hostButton.layer.cornerRadius = 5;
    _hostButton.layer.borderColor = LINE_COLOR.CGColor;
    _hostButton.layer.borderWidth = 0.5;
    _hostButton.textLabel.text =  @"点击选择主持(非必选项)";
    [_hostButton.textLabel sizeToFit];
    _hostButton.textLabel.frame = CGRectMake(5, 0, kScreenWidth-titleW-30, 30);
    [_hostButton sizeToFit];
    _hostButton.frame = CGRectMake(titleW+20, 50, kScreenWidth-titleW-30, 30);
    [self.contentView addSubview:_hostButton];
    
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 95, kScreenWidth- titleW-30, 30)];
    _phoneTF.font = TEXT_FONT_LEVEL_2;
    _phoneTF.returnKeyType = UIReturnKeyDone;
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    _phoneTF.placeholder = @"请输入课程联系人号码";
    [self.contentView addSubview:_phoneTF];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 140, kScreenWidth- titleW-30, 30)];
    _nameTF.font = TEXT_FONT_LEVEL_2;
    _nameTF.returnKeyType = UIReturnKeyDone;
    _nameTF.placeholder = @"请输入课程联系人姓名";
    [self.contentView addSubview:_nameTF];
    
    _freeTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 185, kScreenWidth- titleW-30, 30)];
    _freeTF.font = TEXT_FONT_LEVEL_2;
    _freeTF.returnKeyType = UIReturnKeyDone;
    _freeTF.placeholder = @"请输入课程费用";
    _freeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_freeTF];
    
    //会员费用
    _VipFreeTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 230, kScreenWidth- titleW-30, 30)];
    _VipFreeTF.font = TEXT_FONT_LEVEL_2;
    _VipFreeTF.returnKeyType = UIReturnKeyDone;
    _VipFreeTF.placeholder = @"请输入会员费用";
    _VipFreeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_VipFreeTF];
    
    //加盟商费用
    _couponTF = [[UITextField alloc] initWithFrame:CGRectMake(couponLable.bounds.size.width+20, 275, kScreenWidth- titleW-30, 30)];
    _couponTF.font = TEXT_FONT_LEVEL_2;
    _couponTF.returnKeyType = UIReturnKeyDone;
    _couponTF.placeholder = @"请输入加盟商费用";
    _couponTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_couponTF];
    
    
    //是否抵用
    _UseButton = [LMChoseCounponButton buttonWithType:UIButtonTypeSystem];
    _UseButton.textLabel.text =  @"是";
    _UseButton.chooseImage.backgroundColor = LIVING_COLOR;
    [_UseButton sizeToFit];
    _UseButton.frame = CGRectMake(titleW+20+20, 320, 60, 30);
    
    [self.contentView addSubview:_UseButton];
    
    _unUseButton = [LMChoseCounponButton buttonWithType:UIButtonTypeSystem];
    _unUseButton.textLabel.text =  @"否";
    _unUseButton.chooseImage.backgroundColor = [UIColor clearColor];
    _unUseButton.chooseImage.layer.borderColor = [UIColor blackColor].CGColor;
    [_unUseButton sizeToFit];
    _unUseButton.frame = CGRectMake(titleW+20+20+80, 320, 60, 30);
    [self.contentView addSubview:_unUseButton];
    
    
    
    //参加人数
    _joincountTF = [[UITextField alloc] initWithFrame:CGRectMake(titleW+20, 365, kScreenWidth- titleW-30, 30)];
    _joincountTF.font = TEXT_FONT_LEVEL_2;
    _joincountTF.returnKeyType = UIReturnKeyDone;
    _joincountTF.placeholder = @"请输入参加人数";
    _joincountTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.contentView addSubview:_joincountTF];
    
    
    
    //开始时间
    _dateButton = [LMTimeButton buttonWithType:UIButtonTypeSystem];
    _dateButton.layer.cornerRadius = 5;
    _dateButton.layer.borderColor = LINE_COLOR.CGColor;
    _dateButton.layer.borderWidth = 0.5;
    _dateButton.textLabel.text =  @"请选择课程开始时间";
    [_dateButton.textLabel sizeToFit];
    _dateButton.textLabel.frame = CGRectMake(5, 0, _dateButton.textLabel.bounds.size.width+30, 30);
    [_dateButton sizeToFit];
    _dateButton.frame = CGRectMake(titleW+20, 410, kScreenWidth-titleW-30, 30);
    [self.contentView addSubview:_dateButton];
    
    
    //结束时间
    _endDateButton = [LMTimeButton buttonWithType:UIButtonTypeSystem];
    _endDateButton.layer.cornerRadius = 5;
    _endDateButton.layer.borderColor = LINE_COLOR.CGColor;
    _endDateButton.layer.borderWidth = 0.5;
    _endDateButton.textLabel.text =  @"请选择课程结束时间";
    [_endDateButton.textLabel sizeToFit];
    _endDateButton.textLabel.frame = CGRectMake(5, 0, _endDateButton.textLabel.bounds.size.width+30, 30);
    [_endDateButton sizeToFit];
    _endDateButton.frame = CGRectMake(titleW+20, 455, kScreenWidth-titleW-30, 30);
    [self.contentView addSubview:_endDateButton];
    

    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(titleW+20, 500, kScreenWidth-(titleW+30), 80)];
    backView.layer.borderColor = LINE_COLOR.CGColor;
    backView.layer.borderWidth = 0.5;
    backView.layer.cornerRadius = 5;
    [self.contentView addSubview:backView];
    
    _applyTextView = [[UITextView alloc] initWithFrame:CGRectMake(3, 0, kScreenWidth-(titleW+30+6), 80)];
    
    _msgLabel = [UILabel new];
    _msgLabel.text = @"请输入报名须知内容";
    _msgLabel.font = TEXT_FONT_LEVEL_2;
    _msgLabel.textColor = TEXT_COLOR_LEVEL_2;
    [_msgLabel sizeToFit];
    _msgLabel.frame = CGRectMake(5, 0, _msgLabel.bounds.size.width, 25);
    [_applyTextView addSubview:_msgLabel];
    
    [backView addSubview:_applyTextView];
    
    
    
    
    
    
    UIView *imgBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 625, kScreenWidth, kScreenWidth*3/5)];
    imgBackView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    [self.contentView addSubview:imgBackView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-28, (kScreenWidth*3/5-65)/2, 56, 65)];
    image.image = [UIImage imageNamed:@"publicEvent"];
    [imgBackView addSubview:image];
    
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _imageButton.backgroundColor = [UIColor clearColor];
    _imageButton.frame = CGRectMake(0, 625, kScreenWidth, kScreenWidth*3/5);
    [self.contentView addSubview:_imageButton];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.frame = CGRectMake(0, 625, kScreenWidth, kScreenWidth*3/5);
    [self.contentView addSubview:_imgView];
    
    
    for (int i = 0; i<10; i++) {
        
        if (i==1) {
            
        }else if(i ==6) {
            UIImageView *keyImage = [[UIImageView alloc] initWithFrame:CGRectMake(couponLable.bounds.size.width+10, 10+45*i, 6, 5)];
            keyImage.image = [UIImage imageNamed:@"key"];
            [self.contentView addSubview:keyImage];
        }else{
            UIImageView *keyImage = [[UIImageView alloc] initWithFrame:CGRectMake(imageLable.bounds.size.width+10, 10+45*i, 6, 5)];
            keyImage.image = [UIImage imageNamed:@"key"];
            [self.contentView addSubview:keyImage];
        }

        
    }
    
    UIImageView *keyImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageLable.bounds.size.width+10, 5+590, 6, 5)];
    keyImage2.image = [UIImage imageNamed:@"key"];
    [self.contentView addSubview:keyImage2];
    
}

@end