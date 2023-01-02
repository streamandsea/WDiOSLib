//
//  WDLocationManager.h
//  Hola
//
//  Created by Wind on 2022/12/29.
//

#import "WindBaseManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WDLocaionManagerProtocol <NSObject>

- (void)didUpdateLocation:(NSString *)address latitude:(long)lat longitude:(long)lon;

@end

@interface WDLocationManager : WindBaseManager

- (void)setupLocation;

- (BOOL)isLocationServiceOpen;

@end

NS_ASSUME_NONNULL_END
