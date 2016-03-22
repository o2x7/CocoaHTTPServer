#import "ServerSentEventsExampleAppDelegate.h"
#import "HTTPServer.h"
#import "MyHTTPConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "SSEHTTPConnection.h"
#import <Foundation/Foundation.h>
#import "SSEConnectionManager.h"

// Log levels: off, error, warn, info, verbose
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@implementation ServerSentEventsExampleAppDelegate {
    NSTimer* _timer;
}

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Initalize our http server
	httpServer = [[HTTPServer alloc] init];
    httpServer.port = 7915;
	// Tell server to use our custom MyHTTPConnection class.
//	[httpServer setConnectionClass:[MyHTTPConnection class]];
	[httpServer setConnectionClass:[SSEHTTPConnection class]];
    
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
//	[httpServer setPort:12345];
	
	// Serve files from our embedded Web folder
	NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	DDLogVerbose(@"Setting document root: %@", webPath);
	
	[httpServer setDocumentRoot:webPath];
	
	// Start the server (and check for problems)
	
	NSError *error;
	BOOL success = [httpServer start:&error];
	
	if(!success)
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
    
    [_webView.mainFrame loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:7915"]]];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimerTicked) userInfo:nil repeats:true];
}

-(void)onTimerTicked {
    for (SSEHTTPConnection* connection in SSEConnectionManager.sharedSingleton.activeConnections) {
        [connection.response appendMessageWithid:nil event:nil data:@[@"{\"message\":\"Hello world\"}"]];
    }
}

@end
