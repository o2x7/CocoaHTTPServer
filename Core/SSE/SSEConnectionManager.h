//
//  SSEConnectionManager.h
//  ServerSentEventsExample
//
//  Created by Appareo on 3/22/16.
//
//

#import <Foundation/Foundation.h>
#import "HTTPResponse.h"

@class SSEHTTPConnection;

@interface SSEConnectionManager : NSObject

+(instancetype)sharedSingleton;

-(void)addConnection:(SSEHTTPConnection*)connection;
-(void)removeConnection:(SSEHTTPConnection*)connection;

@property (nonatomic, retain) NSMutableSet<SSEHTTPConnection*>* activeConnections;

@end
