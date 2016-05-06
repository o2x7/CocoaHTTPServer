//
//  SSEConnectionManager.m
//  ServerSentEventsExample
//
//  Created by Appareo on 3/22/16.
//
//

#import "SSEConnectionManager.h"
#import "SSEHTTPConnection.h"

@implementation SSEConnectionManager

-(instancetype)init {
    self = [super init];
    if (self) {
        _activeConnections = [NSMutableSet<SSEHTTPConnection*> new];
    }
    return self;
}

+(instancetype)sharedSingleton {
    static id instance;
    @synchronized(self) {
        if (instance == nil) {
            instance = [self.class new];
        }
    }
    return instance;
}

-(void)addConnection:(SSEHTTPConnection*)connection {
    [_activeConnections addObject:connection];
}

-(void)removeConnection:(SSEHTTPConnection*)connection {
    [_activeConnections removeObject:connection];
}

@end
