//
//  SSEHTTPConnection.m
//  ServerSentEventsExample
//
//  Created by Appareo on 2/10/16.
//
//

#import "SSEHTTPConnection.h"
#import "HTTPResponseTest.h"
#import "SSEResponse.h"
#import "SSEConnectionManager.h"

@implementation SSEHTTPConnection {
    SSEConnectionManager* _connectionManager;
}

-(SSEResponse*)sseResponse {
    if (_response == nil) {
        _response = [[SSEResponse alloc] initWithConnection:self];
    }
    return _response;
}

-(NSObject<HTTPResponse> *)httpResponseForMethod:(NSString*)method URI:(NSString*)path {
    return self.sseResponse;
}

-(void)start {
    if (_connectionManager == nil) {
        _connectionManager = [SSEConnectionManager sharedSingleton];
    }
    
    [_connectionManager addConnection:self];
    [super start];
}

-(void)stop {
    if (_connectionManager == nil) {
        _connectionManager = [SSEConnectionManager sharedSingleton];
    }
    
    [_connectionManager removeConnection:self];
    [super stop];
}

@end
