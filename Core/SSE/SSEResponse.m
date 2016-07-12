//
//  SSEResponse.m
//  ServerSentEventsExample
//
//  Created by Appareo on 2/10/16.
//
//

#import "SSEResponse.h"

@implementation SSEResponse {
    HTTPConnection* _connection;
    NSMutableData* _data;
    NSTimer* _timer;
}

-(id)initWithConnection:(HTTPConnection*)connection {
    if (self) {
        _data = [NSMutableData new];
        _connection = connection;
        dispatch_async(dispatch_get_main_queue(), ^{
//            _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimerTicked) userInfo:nil repeats:true];
            [_data appendData:[@"SSE Stream Open\n\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [_connection responseHasAvailableData:self];
        });

    }
    return self;
}

-(void)appendMessageWithid:(NSString*)identifier event:(NSString*)event data:(NSArray<NSString*>*)dataElements {
    dispatch_sync(dispatch_get_main_queue(), ^{
        @synchronized(self) {
            if (identifier != nil) {
                NSString* formatted = [NSString stringWithFormat:@"id: %@\n", identifier];
                [_data appendData:[formatted dataUsingEncoding:NSUTF8StringEncoding]];
            }
            if (event != nil) {
                NSString* formatted = [NSString stringWithFormat:@"event: %@\n", event];
                [_data appendData:[formatted dataUsingEncoding:NSUTF8StringEncoding]];
            }
            for (NSString* data in dataElements) {
                NSString* formatted = [NSString stringWithFormat:@"data: %@\n", data];
                [_data appendData:[formatted dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            if (identifier != nil || event != nil || dataElements.count > 0) {;
                [_data appendData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [_connection responseHasAvailableData:self];
            }
        }
    });
}

-(UInt64)contentLength {
    return 10000000000;
}

-(UInt64)offset {
    return 0;
}
-(void)setOffset:(UInt64)offset {
    
}
-(NSData *)readDataOfLength:(NSUInteger)length {
    @synchronized(self) {
        NSData* data = _data;
        _data = [NSMutableData new];
        return data;
    }
}

-(BOOL)isDone {
    return false;
}

-(NSInteger)status {
    return 200;
}

-(NSDictionary*)httpHeaders {
    return @{@"Content-Type":@"text/event-stream",
             @"Cache-Control": @"no-cache",
             @"Connection": @"keep-alive"};
}

-(void)connectionDidClose {
    
}

-(BOOL)delayResponseHeaders {
    return false;
}

-(BOOL)isChunked {
    return true;
}

-(BOOL)isAsynchronous {
    return true;
}
@end
