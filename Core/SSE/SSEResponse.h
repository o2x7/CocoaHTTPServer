//
//  SSEResponse.h
//  ServerSentEventsExample
//
//  Created by Appareo on 2/10/16.
//
//

#import "HTTPResponse.h"
#import "HTTPConnection.h"

@interface SSEResponse : NSObject<HTTPResponse>

-(id)initWithConnection:(HTTPConnection*)connection;

-(void)appendMessageWithid:(NSString*)identifier event:(NSString*)event data:(NSArray<NSString*>*)dataElements;

@end
