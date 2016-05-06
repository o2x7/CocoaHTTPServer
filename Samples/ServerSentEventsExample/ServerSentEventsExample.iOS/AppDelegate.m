//
//  AppDelegate.m
//  ServerSentEventsExample.iOS
//
//  Created by Travis Bader on 5/6/16.
//
//

#import "AppDelegate.h"
@import CocoaHTTPServer;

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation AppDelegate {
    HTTPServer *httpServer;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

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
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
