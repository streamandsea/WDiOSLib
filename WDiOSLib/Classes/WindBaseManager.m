//
//  WindBaseManager.m
//  Hola
//
//  Created by Wind on 2022/12/29.
//

#import "WindBaseManager.h"

@implementation WindBaseManager

- (NSRecursiveLock *)delegateLock {
    if (_delegateLock == nil) {
        _delegateLock = [[NSRecursiveLock alloc] init];
    }
    return _delegateLock;
}

+(instancetype)sharedInstance {
    
    static WindBaseManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _delegates = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

- (void)setDelegate:(id)delegate {
    [self.delegateLock lock];
    [self.delegates addObject:delegate];
    [self.delegateLock unlock];
}

- (void)removeDelegate:(id)delegate {
    [self.delegateLock lock];
    [self.delegates removeObject:delegate];
}

@end
