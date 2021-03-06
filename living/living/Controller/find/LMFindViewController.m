//
//  LMFindViewController.m
//  dirty
//
//  Created by Ding on 16/9/22.
//  Copyright © 2016年 Huasheng. All rights reserved.
//

#import "LMFindViewController.h"
#import "LMFindCell.h"
#import "WJLoopView.h"
#import "LMWebViewController.h"
#import "LMFindBannerRequest.h"

#import "LMFindListRequest.h"
#import "LMFindVO.h"
#import "UIImageView+WebCache.h"

#import "LMfindPraiseRequest.h"
#import "LMLessonViewController.h"
#import "LMSegmentViewController.h"


#import "LMYaoGuoBiController.h"

#define PAGER_SIZE      20

@interface LMFindViewController ()
<
WJLoopViewDelegate,
LMFindCellDelegate
>
{
    NSArray *imagearray;
    NSArray *titlearray;
    NSArray *contentarray;
    NSArray *imageURLs;
    
    NSMutableArray *cellDataArray;
    NSInteger        totalPage;
    NSInteger        currentPageIndex;
    NSMutableArray   *pageIndexArray;
    BOOL                reload;
    UIView *headView;
}

@end

@implementation LMFindViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        self.ifRemoveLoadNoState        = NO;
        self.ifShowTableSeparator       = NO;
        self.hidesBottomBarWhenPushed   = NO;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![[FitUserManager sharedUserManager] isLogin]) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm";
        NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
        NSDate * endDate = [formatter dateFromString:REVIEW_TIME];
        NSTimeInterval endInterval = [endDate timeIntervalSince1970];
        NSString * msg;
        if (nowInterval < endInterval) {
            msg = @"请登录";
        }else{
            msg = @"发现页需要对新功能进行投票，请登录";
        }

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:msg
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDestructive
                                                handler:^(UIAlertAction*action) {
                                                    
                                                    [[FitUserManager sharedUserManager] logout];
                                                    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
                                                    
                                                    [self.navigationController popViewControllerAnimated:NO];
                                                    
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:FIT_LOGOUT_NOTIFICATION object:nil];
                                                    
                                                    
                                                    
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction*action) {
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.listData.count == 0) {
        
        [self loadNoState];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    cellDataArray=[NSMutableArray arrayWithCapacity:0];
    pageIndexArray=[NSMutableArray arrayWithCapacity:0];
    
    [self creatUI];
    [self loadNewer];
    
    imagearray = @[@"12.jpg",@"13.jpg",@"14.jpg"];
    titlearray = @[@"腰果 财富现金流养成记",@"腰果 语言课堂",@"腰果 商城"];
    contentarray = @[@"现金流：游戏升级打怪，财商创业思维和个人成长也需要升级，现实版的自我成长养成记，想一起来么。",@"语音课堂：想听倾心已久讲师的经典课程，邀约腰果生活，随时随地用声音传递生活。",@"商场：在商城找到帮助品质生活体验的优质商品，不用到处淘而耗费时间啦."];
}

- (void)creatUI
{
    [super createUI];
    
    self.tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.contentInset                 = UIEdgeInsetsMake(64, 0, 49, 0);
    self.pullToRefreshView.defaultContentInset  = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets        = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:TEXT_COLOR_LEVEL_2};
    self.navigationController.navigationBar.tintColor = TEXT_COLOR_LEVEL_2;
    
    imageURLs =@[@"http://yaoguo.oss-cn-hangzhou.aliyuncs.com/9f8d96ce455e3ce4c168a1a087cfab44.jpg",@"http://yaoguo.oss-cn-hangzhou.aliyuncs.com/dba0b35d39f1513507f0bbac17e90d21.jpg",@"http://yaoguo.oss-cn-hangzhou.aliyuncs.com/c643d748dc1a7c128a8d052def67a92e.jpg",@"http://yaoguo.oss-cn-hangzhou.aliyuncs.com/24437ada0e0fec458a4d4b7bcd6d3b03.jpg"];
    

    
    CGFloat headViewHight = 0.0;
    

        if (kScreenWidth<750) {
            headViewHight =  90+49;
            
        }
        
        if (kScreenWidth == 750) {
            headViewHight =  90+97;
            
        }
        if (kScreenWidth>750) {
            headViewHight =  90+146;
        }

    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*3/5+headViewHight+90-70)];
    headView.backgroundColor = BG_GRAY_COLOR;
    WJLoopView *loopView = [[WJLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*3/5)
                                                    delegate:self
                                                   imageURLs:imageURLs
                                            placeholderImage:nil
                                                timeInterval:8
                              currentPageIndicatorITintColor:nil
                                      pageIndicatorTintColor:nil];
    
    loopView.location = WJPageControlAlignmentRight;
    
    [headView addSubview:loopView];
    
    //语音课堂
    UIView *classView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth*3/5, kScreenWidth, 90)];
    classView.backgroundColor = [UIColor clearColor];
    [headView addSubview:classView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 70)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    [classView addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
    imageView.image = [UIImage imageNamed:@"voiceIcon"];
    [backView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, kScreenWidth-80, 40)];
    titleLabel.text = @"语音课堂，玩转生活";
    titleLabel.font = TEXT_FONT_LEVEL_1;
    [backView addSubview:titleLabel];
    
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 15+13.5, 7, 13)];
    right.image = [UIImage imageNamed:@"rightIcon"];
    [backView addSubview:right];
    
    [classView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceClassenter)]];
    
    //腰果币
    UIView *ygbView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth*3/5+90, kScreenWidth, headViewHight-70)];
    ygbView.backgroundColor = [UIColor clearColor];
    [headView addSubview:ygbView];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 70)];
    backView2.backgroundColor = [UIColor whiteColor];
    backView2.layer.cornerRadius = 5;
    //[ygbView addSubview:backView2];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 40, 40)];
    imageView2.image = [UIImage imageNamed:@"shareIcon"];
    imageView2.layer.masksToBounds = YES;
    imageView2.layer.cornerRadius = 5;
    [backView2 addSubview:imageView2];
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, kScreenWidth-80, 40)];
    titleLabel2.text = @"腰果币";
    titleLabel2.font = TEXT_FONT_LEVEL_1;
    [backView2 addSubview:titleLabel2];
    
    UIImageView *right2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-40, 15+13.5, 7, 13)];
    right2.image = [UIImage imageNamed:@"rightIcon"];
    [backView2 addSubview:right2];
    
    [backView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myYGB)]];
    
    //共创社区
    if (kScreenWidth<750) {
        UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90-80, kScreenWidth, 49)];
        footView.image = [UIImage imageNamed:@"VoiceImage"];
        footView.userInteractionEnabled = NO;
        [ygbView addSubview:footView];
    }
    
    if (kScreenWidth == 750) {
        UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90-80, kScreenWidth, 97)];
        footView.image = [UIImage imageNamed:@"VoiceImage"];
        footView.userInteractionEnabled = NO;
        [ygbView addSubview:footView];
    }
    if (kScreenWidth>750) {
        UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90-80, kScreenWidth, 146)];
        footView.image = [UIImage imageNamed:@"VoiceImage"];
        footView.userInteractionEnabled = NO;
        [ygbView addSubview:footView];
    }
    
    

    
    self.tableView.tableHeaderView = headView;
}
#pragma mark - 请求数据
- (FitBaseRequest *)request
{
    LMFindListRequest    *request    = [[LMFindListRequest alloc] initWithPageIndex:self.current andPageSize:PAGER_SIZE];
    
    return request;
}

- (NSArray *)parseResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    NSString    *result         = [bodyDic objectForKey:@"result"];
    NSString    *description    = [bodyDic objectForKey:@"description"];
    
    if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSString class]] && [result isEqualToString:@"0"]) {
        
        self.max    = [[bodyDic objectForKey:@"total"] intValue];
        
        return [LMFindVO LMFindVOListWithArray:[bodyDic objectForKey:@"list"]];
        
    } else if (description && ![description isEqual:[NSNull null]] && [description isKindOfClass:[NSString class]]) {
        
        [self performSelectorOnMainThread:@selector(textStateHUD:) withObject:description waitUntilDone:NO];
    }
    
    return nil;
}

#pragma mark scrollview代理函数

- (void)WJLoopView:(WJLoopView *)LoopView didClickImageIndex:(NSInteger)index
{
    if (index == 3) {
        
        return;
    }
    
    NSArray *arr = @[@"『腰·美』",@"『腰·吃』",@"『腰·活』",@"『腰·乐』"];
    NSArray *urlRrray = @[@"http://yaoguo1818.com/living-web/mentor-introduce-beauty.html",
                          @"http://yaoguo1818.com/living-web/mentor-introduce-food.html",
                          @"http://yaoguo1818.com/living-web/mentor-introduce-health.html"];
    
    LMWebViewController *webView    = [[LMWebViewController alloc] init];
    
    webView.urlString       = urlRrray[index];
    webView.titleString     = arr[index];
    webView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h   = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
    if (h) {
        
        return h;
    }
    
    return 175;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell   = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (cell) {
        
        return cell;
    }
    
    cell    = [tableView dequeueReusableCellWithIdentifier:cellId];
        
    if (!cell) {
            
            cell    = [[LMFindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        if (self.listData.count > indexPath.row) {
            
            LMFindVO     *vo = self.listData[indexPath.row];
            
            if (vo && [vo isKindOfClass:[LMFindVO class]]) {
                
                [(LMFindCell *)cell setValue:vo];
            }
        }
        
        cell.tag = indexPath.row;
        [(LMFindCell *)cell setDelegate:self];
            

    
    return cell;
}
#pragma mark - 手势点击
- (void)voiceClassenter
{
    LMSegmentViewController *lessonVC = [[LMSegmentViewController alloc] init];
    lessonVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:lessonVC animated:YES];
}

- (void)myYGB{
    LMYaoGuoBiController * ygbVC = [[LMYaoGuoBiController alloc] init];
    [self.navigationController pushViewController:ygbVC animated:YES];
    
}




- (void)cellWillClick:(LMFindCell *)cell
{
    if (self.listData.count > cell.tag) {
        
        LMFindVO *vo     = [self.listData objectAtIndex:cell.tag];
        
        if (vo && [vo isKindOfClass:[LMFindVO class]]) {
            
            [self praiseRequest:vo.findUuid];
        }
    }
}

#pragma mark

- (void)praiseRequest:(NSString *)uuid
{
    if ([[FitUserManager sharedUserManager] isLogin]) {
        if (![CheckUtils isLink]) {
            
            [self textStateHUD:@"无网络连接"];
            return;
        }
        
        LMfindPraiseRequest *request = [[LMfindPraiseRequest alloc] initWithPageFindUUID:uuid];
        HTTPProxy   *proxy  = [HTTPProxy loadWithRequest:request
                                               completed:^(NSString *resp, NSStringEncoding encoding) {
                                                   
                                                   [self performSelectorOnMainThread:@selector(praiseDataResponse:)
                                                                          withObject:resp
                                                                       waitUntilDone:YES];
                                               } failed:^(NSError *error) {
                                                   
                                                   [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                          withObject:@"网络错误"
                                                                       waitUntilDone:YES];
                                               }];
        [proxy start];
        
    }else{
        
        [self IsLoginIn];
    }
}

- (void)praiseDataResponse:(NSString *)resp
{
    NSDictionary *bodyDic = [VOUtil parseBody:resp];
    
    if ([[bodyDic objectForKey:@"result"] isEqual:@"0"]) {
        
        [self textStateHUD:@"投票成功"];
        
         [self loadNoState];
        
    } else {
        
        NSString *str = [bodyDic objectForKey:@"description"];
        [self textStateHUD:str];
    }
}

@end
