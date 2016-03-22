#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
@import WebKit;

@class HTTPServer;


@interface ServerSentEventsExampleAppDelegate : NSObject <NSApplicationDelegate>
{
	HTTPServer *httpServer;
	
	NSWindow *__unsafe_unretained window;
}
@property (weak) IBOutlet WebView *webView;

@property (unsafe_unretained) IBOutlet NSWindow *window;

@end
