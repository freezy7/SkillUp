//
//  MMLocationManager.m
//  NeedForSpeed
//
//  Created by R_flava_Man on 16/2/1.
//  Copyright © 2016年 R_style_Man. All rights reserved.
//

#import "MMLocationManager.h"

@interface MMLocationManager ()<CLLocationManagerDelegate>
{
    
}

@end

@implementation MMLocationManager

+ (id)sharedManager
{
    static MMLocationManager *_manager;
    if (_manager == nil) {
        _manager = [[MMLocationManager alloc] init];
    }
    return _manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.minSpeed = 3;
        self.minFilter = 50;
        self.minInteval = 10;
        
        self.delegate = self;
        self.distanceFilter = self.minFilter;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        
    }
    return self;
}

- (void)adjustDistanceFilter:(CLLocation *)location
{
    if (location.speed < self.minSpeed) {
        if (fabs(self.distanceFilter - self.minFilter) > 0.1f) {
            self.distanceFilter = self.minFilter;
        }
    } else {
        CGFloat lastSpeed = self.distanceFilter/self.minInteval;
        
        if (fabs(lastSpeed-location.speed)/lastSpeed > 0.1f || lastSpeed < 0) {
            CGFloat newSpeed = (int)(location.speed + 0.5f);
            CGFloat newFilter = newSpeed * self.minInteval;
            
            self.distanceFilter = newFilter;
        }
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations[0];
    
    NSLog(@"%@",location);
    
    //根据实际情况来调整触发范围
    
    [self adjustDistanceFilter:location];
}



@end
