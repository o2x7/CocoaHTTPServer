//
//  SSEConnection.m
//  CocoaHTTPServer
//
//  Created by Travis Bader on 5/6/16.
//  Copyright © 2016 Appareo Systems. All rights reserved.
//

#import "SSEConnection.h"
#import "SSEResponse.h"

@implementation SSEConnection

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString*)method URI:(NSString*)path {
    return [SSEResponse new];
}

@end
