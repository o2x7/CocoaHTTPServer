//
//  SSEHTTPConnection.h
//  ServerSentEventsExample
//
//  Created by Appareo on 2/10/16.
//
//

#import "HTTPConnection.h"
#import "SSEResponse.h"

@interface SSEHTTPConnection : HTTPConnection

@property (nonatomic, retain) SSEResponse* response;

@end
