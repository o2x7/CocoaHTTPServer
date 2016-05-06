//
//  ViewController.m
//  ServerSentEventsExample.iOS
//
//  Created by Travis Bader on 5/6/16.
//
//

#import "ViewController.h"
@import CocoaHTTPServer;

@implementation ViewController {
    NSTimer* _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimerTicked) userInfo:nil repeats:true];
}

-(void)viewDidAppear:(BOOL)animated {
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:7915"]]];
}

-(void)onTimerTicked {
    for (SSEHTTPConnection* connection in SSEConnectionManager.sharedSingleton.activeConnections) {
        [connection.response appendMessageWithid:nil event:nil data:@[@"{\"message\":\"Hello world\"}"]];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"Error %@", error);
}

@end
