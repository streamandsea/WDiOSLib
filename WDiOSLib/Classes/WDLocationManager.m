//
//  WDLocationManager.m
//  Hola
//
//  Created by Wind on 2022/12/29.
//

#import "WDLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface WDLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation WDLocationManager

- (void)setupLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //精确度获取到米
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置过滤器为无
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    // 取得定位权限，有两个方法，取决于你的定位使用情况
    //一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [self.locationManager requestWhenInUseAuthorization];
    //开始获取定位
    [self.locationManager startUpdatingLocation];
}

- (BOOL)isLocationServiceOpen  {
    /* [CLLocationManager locationServicesEnabled] tbd
     *
     * This method can cause UI unresponsiveness if invoked on the main thread.
     * Instead, consider waiting for the `-locationManagerDidChangeAuthorization:`
     * callback and checking `authorizationStatus` first.
    */
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
        [CLLocationManager locationServicesEnabled]) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - location manager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [self.locationManager stopUpdatingLocation];
    __weak typeof (self) weakSelf = self;
    if(@available(iOS 11.0, *)) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
        NSString * preferredLang = [allLanguages objectAtIndex:0];
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:preferredLang];
        [gecoder reverseGeocodeLocation:location
                              preferredLocale:locale
                            completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks,
                                                NSError * _Nullable error) {
            if (!error) {
                NSDictionary *addressDic = placemarks.lastObject.addressDictionary;
                NSString *city=[addressDic objectForKey:@"City"];
                NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                NSString *street=[addressDic objectForKey:@"Street"];
                NSString *addressDetails = [NSString stringWithFormat:@"%@%@%@",city,subLocality,street];
                for (id delegate in weakSelf.delegates) {
                    if ([delegate respondsToSelector:@selector(didUpdateLocation:latitude:longitude:)]) {
                        [delegate didUpdateLocation:addressDetails
                                           latitude:location.coordinate.latitude
                                          longitude:location.coordinate.longitude];
                    }
                }
            } else {
                NSLog(@"%@",error);
                for (id delegate in weakSelf.delegates) {
                    if ([delegate respondsToSelector:@selector(didUpdateLocation:latitude:longitude:)]) {
                        [delegate didUpdateLocation:@""
                                           latitude:location.coordinate.latitude
                                          longitude:location.coordinate.longitude];
                    }
                }
            }
        }];
    }
    else {
        [gecoder reverseGeocodeLocation:location
                            completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                CLPlacemark *placemark = placemarks.lastObject;
                NSDictionary *addressDic = placemark.addressDictionary;
                NSString *city=[addressDic objectForKey:@"City"];
                NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                NSString *street=[addressDic objectForKey:@"Street"];
                NSString *addressDetails = [NSString stringWithFormat:@"%@%@%@",city,subLocality,street];
                for (id delegate in weakSelf.delegates) {
                    if ([delegate respondsToSelector:@selector(didUpdateLocation:latitude:longitude:)]) {
                        [delegate didUpdateLocation:addressDetails
                                           latitude:location.coordinate.latitude
                                          longitude:location.coordinate.longitude];
                    }
                }
            } else {
                NSLog(@"%@",error);
                for (id delegate in weakSelf.delegates) {
                    if ([delegate respondsToSelector:@selector(didUpdateLocation:latitude:longitude:)]) {
                        [delegate didUpdateLocation:@""
                                           latitude:location.coordinate.latitude
                                          longitude:location.coordinate.longitude];
                    }
                }
            }
        }];
    }
}

@end
