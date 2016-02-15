//
//  MMLocationManager.h
//  NeedForSpeed
//
//  Created by R_flava_Man on 16/2/1.
//  Copyright © 2016年 R_style_Man. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MMLocationManager : CLLocationManager

+ (instancetype)sharedManager;

@property (nonatomic, assign) CGFloat minSpeed;//最小速度
@property (nonatomic, assign) CGFloat minFilter;    //最小范围
@property (nonatomic, assign) CGFloat minInteval;   //更新间隔

@end
