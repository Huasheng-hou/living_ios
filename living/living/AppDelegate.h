//
//  AppDelegate.h
//  living
//
//  Created by Ding on 16/9/26.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import <MBProgressHUD.h>
#import "GeTuiSdk.h"

@interface AppDelegate : UIResponder
<
UIApplicationDelegate,
MBProgressHUDDelegate,
GeTuiSdkDelegate
>

@property (strong, nonatomic) UIWindow  *window;
@property (retain, nonatomic) NSString  *deviceToken;

@end
