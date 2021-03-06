//
//  DYHomePageController.m
//  dirty
//
//  Created by Ding on 16/8/23.
//  Copyright © 2016年 Huasheng. All rights reserved.
//

#import "LMHomePageController.h"
#import "LMActivityDetailController.h"
#import "LMHomeDetailController.h"
#import "LMBannerrequest.h"
#import "LMHomelistequest.h"
#import "LMhomePageCell.h"
#import "LMActicleVO.h"

#import "WJLoopView.h"
#import "LMPublicArticleController.h"
#import "MJRefresh.h"
#import "LMWriterViewController.h"
#import "LMWebViewController.h"

#import "LMArtcleTypeViewController.h"
#import "LMHomeVoiceDetailController.h"
#import "LMClassroomDetailViewController.h"

#import "BannerVO.h"

#import "LMRecommendCell.h"
#import "HotArticleCell.h"
#import "LMHomeBannerView.h"
#import "LMBannerDetailController.h"

#import "LMBannerDetailMakerController.h"
#import "LMYaoGuoBiController.h"

#import "LMRecommendArticleRequest.h"
#import "LMRecommendVO.h"

#import "LMActivityDetailController.h"
#import "LMEventDetailViewController.h"
#import "LMClassroomDetailViewController.h"

typedef struct Test
{
    int a;
    int b;
}Test;

#define PAGER_SIZE      20

@interface LMHomePageController ()
<
UITableViewDelegate,
UITableViewDataSource,
LMHomeBannerDelegate,
WJLoopViewDelegate
>
//LMhomePageCellDelegate

{
    UIView *headView;
    UIBarButtonItem *backItem;
    
    NSIndexPath *deleteIndexPath;
    
    NSInteger        totalPage;
    NSInteger        currentPageIndex;
    
    NSArray         *_bannerArray;
    NSMutableArray  *stateArray;
    
    
    NSArray * sectionList;
    
    NSArray * _recommendArray;
}

@end

@implementation LMHomePageController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
        self.ifRemoveLoadNoState        = NO;
        self.ifShowTableSeparator       = NO;
        self.hidesBottomBarWhenPushed   = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNoState) name:@"reloadHomePage" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNoState) name:@"reloadlist" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fromShare:) name:@"goToDetailFromShareLink" object:nil];
    }
    
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    if ([[FitUserManager sharedUserManager] isLogin]) {

        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(publicAction)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self initStateHud];
    });
    
    [self creatUI];
    
    //[self getRecommendArticleRequest];
    [self loadNewer];
}

- (void)creatUI
{
    [super createUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    self.tableView.keyboardDismissMode          = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.contentInset                 = UIEdgeInsetsMake(64, 0, 49, 0);
    self.pullToRefreshView.defaultContentInset  = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.scrollIndicatorInsets        = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:TEXT_COLOR_LEVEL_2};
    self.navigationController.navigationBar.tintColor = TEXT_COLOR_LEVEL_2;
    sectionList = @[@"腰果推荐", @"热门文章"];
    
    LMHomeBannerView * banner = [[LMHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 132)];
    banner.delegate = self;
    self.tableView.tableHeaderView = banner;
}

- (void)adjustIndicator:(UIView *)loadingView
{
    if (loadingView) {
        
        for (UIView * subView in loadingView.subviews) {
            
            if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
                
                subView.center  = CGPointMake(subView.center.x, subView.center.y + 100);
            }
        }
    }
}


#pragma mark 发布文章
- (void)publicAction
{
    LMPublicArticleController *publicVC = [[LMPublicArticleController alloc] init];
    [self.navigationController pushViewController:publicVC animated:YES];
}
#pragma mark - 推荐数据请求
//推荐
- (void)getRecommendArticleRequest{
    
    if (![CheckUtils isLink]) {
        
        [self textStateHUD:@"无网络连接"];
        return;
    }
    LMRecommendArticleRequest * request = [[LMRecommendArticleRequest alloc] init];
    HTTPProxy * proxy = [HTTPProxy loadWithRequest:request
                                         completed:^(NSString *resp, NSStringEncoding encoding) {

                                             [self performSelectorOnMainThread:@selector(parseData:)
                                                                    withObject:resp
                                                                 waitUntilDone:YES];
                                         }
                                            failed:^(NSError *error) {
                                                
                                                [self performSelectorOnMainThread:@selector(textStateHUD:)
                                                                       withObject:@"网络错误"
                                                                    waitUntilDone:YES];
                                            }];
    
    
    [proxy start];
}
- (void)parseData:(NSString *)resp{
    
    NSString * franchisee;
    NSDictionary * bodyDic = [VOUtil parseBody:resp];
    
    NSData * respData = [resp dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSDictionary * respDict = [NSJSONSerialization JSONObjectWithData:respData
                                                              options:NSJSONReadingMutableContainers
                                                                error:nil];
    NSDictionary * headDict = [respDict objectForKey:@"head"];
    NSString * returnCode = [headDict objectForKey:@"returnCode"];
    
    if ([returnCode isEqualToString:@"000"])
    {
        if ([headDict objectForKey:@"franchisee"] && ![[headDict objectForKey:@"franchisee"] isEqual:[NSNull null]]
            && [[headDict objectForKey:@"franchisee"] isKindOfClass:[NSString class]] && [headDict[@"franchisee"] isEqual:@"yes"]) {
            
            franchisee = @"yes";
        }
    }
    NSString    *result         = [bodyDic objectForKey:@"result"];
    NSString    *description    = [bodyDic objectForKey:@"description"];
    
    if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSString class]] && [result isEqualToString:@"0"]) {
        
        self.max    = [[bodyDic objectForKey:@"total"] intValue];
        
        _recommendArray = [LMRecommendVO LMRecommendVOListWithArray:[bodyDic objectForKey:@"list"]];
        
    } else if (description && ![description isEqual:[NSNull null]] && [description isKindOfClass:[NSString class]]) {
        
        [self performSelectorOnMainThread:@selector(textStateHUD:) withObject:description waitUntilDone:NO];
    }

}

#pragma mark - 热门文章  --  原首页文章列表
- (FitBaseRequest *)request
{
    [self getRecommendArticleRequest];
    LMHomelistequest    *request    = [[LMHomelistequest alloc] initWithPageIndex:self.current andPageSize:PAGER_SIZE];
    
    return request;
}

- (NSArray *)parseResponse:(NSString *)resp
{
    
    NSString        *franchisee;
    NSDictionary    *bodyDic        = [VOUtil parseBody:resp];
    
    NSData          *respData = [resp dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSDictionary    *respDict = [NSJSONSerialization JSONObjectWithData:respData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
    
    NSDictionary *headDic = [respDict objectForKey:@"head"];
    NSString    *coderesult         = [headDic objectForKey:@"returnCode"];
    
    if (coderesult && ![coderesult isEqual:[NSNull null]] && [coderesult isKindOfClass:[NSString class]] && [coderesult isEqualToString:@"000"]) {
        
        if ([headDic objectForKey:@"franchisee"] && ![[headDic objectForKey:@"franchisee"] isEqual:[NSNull null]]
            && [[headDic objectForKey:@"franchisee"] isKindOfClass:[NSString class]] && [headDic[@"franchisee"] isEqual:@"yes"]) {
            
            franchisee = @"yes";
        }
    }
    
    NSString    *result         = [bodyDic objectForKey:@"result"];
    NSString    *description    = [bodyDic objectForKey:@"description"];
    
    if (result && ![result isEqual:[NSNull null]] && [result isKindOfClass:[NSString class]] && [result isEqualToString:@"0"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideStateHud];
        });

        self.max    = [[bodyDic objectForKey:@"total"] intValue];
        
        return [LMActicleVO LMActicleVOListWithArray:[bodyDic objectForKey:@"list"]];
        
    } else if (description && ![description isEqual:[NSNull null]] && [description isKindOfClass:[NSString class]]) {
        
        [self performSelectorOnMainThread:@selector(textStateHUD:) withObject:description waitUntilDone:NO];
    }
    
    return nil;
}

#pragma mark  - banner代理函数
- (void)gotoNextPage:(NSInteger)index{
    
        switch (index) {
        case 10:
        {
            LMBannerDetailController * bdVC = [[LMBannerDetailController alloc] initWithIndex:index];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];
            //NSLog(@"Yao·美丽");
            bdVC.navigationItem.title = @"Yao·美丽";
            [self.navigationController pushViewController:bdVC animated:YES];
            break;
        }
        case 11:
        {
            LMBannerDetailController * bdVC = [[LMBannerDetailController alloc] initWithIndex:index];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];

            //NSLog(@"Yao·健康");
            bdVC.navigationItem.title = @"Yao·健康";
            [self.navigationController pushViewController:bdVC animated:YES];
            break;
        }
        case 12:
        {
            LMBannerDetailController * bdVC = [[LMBannerDetailController alloc] initWithIndex:index];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];

            //NSLog(@"Yao·美食");
            bdVC.navigationItem.title = @"Yao·美食";
            [self.navigationController pushViewController:bdVC animated:YES];
            break;
        }
        case 13:
        {
                
            LMBannerDetailController * bdVC = [[LMBannerDetailController alloc] initWithIndex:index];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];
            //NSLog(@"Yao·幸福");
            bdVC.navigationItem.title = @"Yao·幸福";
            [self.navigationController pushViewController:bdVC animated:YES];
            break;
        }
        case 14:
        {
            //NSLog(@"Yao·创客");
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];
            LMBannerDetailMakerController * maker = [[LMBannerDetailMakerController alloc] init];
            maker.title = @"Yao·创客";
            [self.navigationController pushViewController:maker animated:YES];
            break;
        }
        case 15:
        {
            //NSLog(@"Yao·果币");
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                                     style:UIBarButtonItemStylePlain
                                                                                    target:self
                                                                                    action:nil];
            LMYaoGuoBiController * ygbVC = [[LMYaoGuoBiController alloc] init];
            ygbVC.title = @"Yao·果币";
            [self.navigationController pushViewController:ygbVC animated:YES];
            break;
        }
            
        default:
            break;
    }

}

#pragma mark - scrollview代理函数

- (void)WJLoopView:(WJLoopView *)LoopView didClickImageIndex:(NSInteger)index
{
    if (_bannerArray.count>index) {
        
        BannerVO *vo = _bannerArray[index];
        //活动
        if ([vo.Type isEqualToString:@"event"]) {
            
            if (vo.KeyUUID && [vo.KeyUUID isKindOfClass:[NSString class]] && ![vo.KeyUUID isEqual:@""]){
            
                LMActivityDetailController *eventVC = [[LMActivityDetailController alloc] init];
                
                eventVC.hidesBottomBarWhenPushed = YES;
                eventVC.eventUuid = vo.KeyUUID;
                
                [self.navigationController pushViewController:eventVC animated:YES];
            }
        }
        //文章
        if ([vo.Type isEqualToString:@"article"]) {
            
            if (vo.KeyUUID && [vo.KeyUUID isKindOfClass:[NSString class]] && ![vo.KeyUUID isEqual:@""]) {
            
                LMHomeDetailController *eventVC = [[LMHomeDetailController alloc] init];
                
                eventVC.hidesBottomBarWhenPushed = YES;
                eventVC.artcleuuid = vo.KeyUUID;
                
                [self.navigationController pushViewController:eventVC animated:YES];
            }
        }
        //web
        if ([vo.Type isEqualToString:@"web"]) {
            
            if (vo.webUrl && [vo.webUrl isKindOfClass:[NSString class]] && ![vo.webUrl isEqualToString:@""]) {
                
                LMWebViewController *webVC = [[LMWebViewController alloc] init];
                
                webVC.hidesBottomBarWhenPushed  = YES;
                webVC.titleString               = vo.webTitle ;
                webVC.urlString                 = vo.webUrl;
                
                [self.navigationController pushViewController:webVC animated:YES];
            }
        }
        //语音课堂
        if ([vo.Type isEqualToString:@"voice"]) {
            
            if (vo.KeyUUID && [vo.KeyUUID isKindOfClass:[NSString class]] && ![vo.KeyUUID isEqual:@""]) {
                
                LMClassroomDetailViewController *eventVC = [[LMClassroomDetailViewController alloc] init];
                
                eventVC.hidesBottomBarWhenPushed = YES;
                eventVC.voiceUUid = vo.KeyUUID;
                
                [self.navigationController pushViewController:eventVC animated:YES];
            }
        }
    }
}
#pragma mark - tableView代理函数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return _recommendArray.count;
    }
    
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        return 110;
    }
    if (indexPath.section == 1) {
        return 215;
    }
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        UILabel * headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.size.width, 20)];
        headerTitle.backgroundColor = [UIColor whiteColor];
        headerTitle.textColor = TEXT_COLOR_LEVEL_3;
        headerTitle.font = TEXT_FONT_LEVEL_3;
        headerTitle.numberOfLines = 2;
        
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:@"   丨  腰果推荐"];
        [attr addAttribute:NSForegroundColorAttributeName value:LIVING_COLOR range:NSMakeRange(0, 6)];
        headerTitle.attributedText = [[NSAttributedString alloc] initWithAttributedString:attr];
        [headerView addSubview:headerTitle];
    }else{
        UILabel * headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, tableView.size.width, 20)];
        headerTitle.backgroundColor = [UIColor whiteColor];
        headerTitle.textColor = TEXT_COLOR_LEVEL_3;
        headerTitle.font = TEXT_FONT_LEVEL_3;
        NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithString:@"   丨  热门文章"];
        [attr addAttribute:NSForegroundColorAttributeName value:LIVING_COLOR range:NSMakeRange(0, 6)];
        headerTitle.attributedText = attr;
        [headerView addSubview:headerTitle];
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    if (indexPath.section == 0) {
        LMRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[LMRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_recommendArray.count > indexPath.row) {
            LMRecommendVO * vo = _recommendArray[indexPath.row];
            if (vo) {
                [(LMRecommendCell *)cell setValue:vo];
            }

        }
        return cell;
    }
    if (indexPath.section == 1) {
        
        HotArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[HotArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.listData.count > indexPath.row) {
            
            LMActicleVO * vo = self.listData[indexPath.row];
            
            [cell setValue:vo];

        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //LMRecommendVO * vo = _recommendArray[10000];
    //SIGBUS，内存地址未对齐
    //EXC_BAD_ACCESS(code=1,address=0x1000dba58)
//    char *s = "hello world";
//    *s = 'H';
    
//    Test *pTest = {1, 2};
//    free(pTest);//导致SIGABRT的错误，因为内存中根本就没有这个空间，哪来的free，就在栈中的对象而已
//    pTest->a = 5;
    
    
    if (indexPath.section == 0) {
        LMRecommendVO * vo = _recommendArray[indexPath.row];
        if (vo) {
            if (vo.group && [vo.group isEqualToString:@"article"]) {
                LMHomeDetailController *detailVC = [[LMHomeDetailController alloc] init];
                
                detailVC.hidesBottomBarWhenPushed = YES;
                detailVC.artcleuuid = vo.articleUuid;
                detailVC.franchisee = vo.franchisee;
                detailVC.sign = vo.sign;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
            if (vo.group&&[vo.group isEqualToString:@"voice"]) {
                LMHomeVoiceDetailController *detailVC = [[LMHomeVoiceDetailController alloc] init];
                
                detailVC.hidesBottomBarWhenPushed = YES;
                detailVC.voiceUuid = vo.articleUuid;
                detailVC.franchisee = vo.franchisee;
                detailVC.sign = vo.sign;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
        
    }
    if (indexPath.section == 1) {
        
        if (self.listData.count > indexPath.row) {
            
            LMActicleVO * vo = [self.listData objectAtIndex:indexPath.row];
            
            if (vo && [vo isKindOfClass:[LMActicleVO class]]) {
                
                if (vo.group&&[vo.group isEqualToString:@"article"]) {
                    LMHomeDetailController *detailVC = [[LMHomeDetailController alloc] init];
                    
                    detailVC.hidesBottomBarWhenPushed = YES;
                    detailVC.artcleuuid = vo.articleUuid;
                    detailVC.franchisee = vo.franchisee;
                    detailVC.sign = vo.sign;
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
                
                if (vo.group&&[vo.group isEqualToString:@"voice"]) {
                    LMHomeVoiceDetailController *detailVC = [[LMHomeVoiceDetailController alloc] init];
                    
                    detailVC.hidesBottomBarWhenPushed = YES;
                    detailVC.voiceUuid = vo.articleUuid;
                    detailVC.franchisee = vo.franchisee;
                    detailVC.sign = vo.sign;
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark  - cell click delegate

- (void)cellWillClick:(LMhomePageCell *)cell
{
    if (self.listData.count > cell.tag) {
        
        LMActicleVO *vo     = [self.listData objectAtIndex:cell.tag];
        
        if (vo && [vo isKindOfClass:[LMActicleVO class]]) {
            
            LMWriterViewController *writerVC = [[LMWriterViewController alloc] initWithUUid:vo.userUuid];
            writerVC.hidesBottomBarWhenPushed = YES;
            writerVC.franchisee = vo.franchisee;
            writerVC.sign = vo.sign;
            [self.navigationController pushViewController:writerVC animated:YES];
        }
    }
}

- (void)TitlewillClick:(LMhomePageCell *)cell
{
    if (self.listData.count>cell.tag) {
        LMActicleVO *vo     = [self.listData objectAtIndex:cell.tag];
        if (vo && [vo isKindOfClass:[LMActicleVO class]]) {
            
            LMArtcleTypeViewController *writerVC = [[LMArtcleTypeViewController alloc] initWithType:vo.type];
            writerVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:writerVC animated:YES];
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (fabs(self.tableView.contentSize.height - (self.tableView.contentOffset.y + CGRectGetHeight(self.tableView.frame) - 49)) < 44.0
        && self.statefulState == FitStatefulTableViewControllerStateIdle
        && [self canLoadMore]) {
        [self performSelectorInBackground:@selector(loadNextPage) withObject:nil];
    }
}


#pragma mark - 点击外部分享链接打开APP
- (void)fromShare:(NSNotification *)noti {
    
    NSDictionary * userInfo = noti.userInfo;
    if ([userInfo[@"type"] isEqualToString:@"0"]) {//文章
        
        LMHomeDetailController *detailVC = [[LMHomeDetailController alloc] init];
        detailVC.artcleuuid = userInfo[@"uuid"];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if ([userInfo[@"type"] isEqualToString:@"1"]) {//活动
        
        LMActivityDetailController *detailVC = [[LMActivityDetailController alloc] init];
        detailVC.eventUuid = userInfo[@"uuid"];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if ([userInfo[@"type"] isEqualToString:@"2"]) {//项目
        
        LMEventDetailViewController *detailVC = [[LMEventDetailViewController alloc] init];
        detailVC.eventUuid = userInfo[@"uuid"];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if ([userInfo[@"type"] isEqualToString:@"3"]) {//课程
        
        LMClassroomDetailViewController *detailVC = [[LMClassroomDetailViewController alloc] init];
        detailVC.voiceUUid = userInfo[@"uuid"];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
    
}

@end
