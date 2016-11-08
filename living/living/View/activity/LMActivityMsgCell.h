//
//  LMActivityMsgCell.h
//  living
//
//  Created by Ding on 16/9/30.
//  Copyright © 2016年 chenle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMEventBodyVO.h"
#import <MapKit/MapKit.h>
//#import <MAMapKit/MAMapKit.h>

@interface LMActivityMsgCell : UITableViewCell


@property (nonatomic, strong)NSString *phone;

@property (nonatomic, strong)NSString *price;

@property (nonatomic, strong)NSString *time;


@property (nonatomic, strong)NSString *address;


@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *addressLabel;//地址

@property(nonatomic,strong)MKMapView *mapView;

@property (nonatomic, readonly) float xScale;
@property (nonatomic, readonly) float yScale;

-(void)setValue:(LMEventBodyVO *)event andLatitude:(NSString *)latitude andLongtitude:(NSString *)longtitude;

- (void)setXScale:(float)xScale yScale:(float)yScale;

@end
