//
//  WindBaseManager.h
//  Hola
//
//  Created by Wind on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WindBaseManager : NSObject

@property (strong, nonatomic, readonly) NSHashTable *delegates;

@property (strong, nonatomic) NSRecursiveLock *delegateLock;

+(instancetype)sharedInstance;

// Add single delegate
- (void)setDelegate:(id)delegate;

// Remove single delegate
- (void)removeDelegate:(id)delegate;


@end

NS_ASSUME_NONNULL_END
