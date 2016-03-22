//
//  SSEConnection.swift
//  ServerSentEventsExample
//
//  Created by Appareo on 2/10/16.
//
//

import Foundation

public class SSEConnection: HTTPConnection {

    //- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path;
    public func httpResponseForMethod(method:String, path:String) -> HTTPResponse {
        let response = HTTPResponseTest()
        return response
    }
    
}
