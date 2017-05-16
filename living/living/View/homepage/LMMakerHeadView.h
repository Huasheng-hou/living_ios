//
//  LMMakerHeadView.h
//  living
//
//  Created by Huasheng on 2017/2/24.
//  Copyright © 2017年 chenle. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LMMakerDelegate <NSObject>

- (void)gotoNextPage;

@end

@interface LMMakerHeadView : UIView
@property (nonatomic, weak) id <LMMakerDelegate> delegate;

- (void)setValue:(NSDictionary *)dict;

@end