#import <Foundation/Foundation.h>
@class HTTPMessage;

@interface RouteRequest : NSObject

@property (nonatomic, readonly) NSDictionary<NSString*, NSString*> *headers;
@property (nonatomic, readonly) NSDictionary<NSString*, NSString*> *params;

- (id)initWithHTTPMessage:(HTTPMessage *)msg parameters:(NSDictionary *)params;
- (NSString *)header:(NSString *)field;
- (id)param:(NSString *)name;
- (NSString *)method;
- (NSURL *)url;
- (NSData *)body;

@end
