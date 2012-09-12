

#import "HTTPRequester.h"
#import <objc/message.h>

static HTTPRequester *sharedInstance = nil;

@interface HTTPRequester ()

@property (nonatomic, assign) CFMutableDictionaryRef connectionData;

@end



@implementation HTTPRequester

+ (HTTPRequester *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];    
    if (self) {
        _connectionData = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

#pragma mark - GET Interface

- (void)getRequest:(HTTPRequest *)httpRequest {

    NSString *urlString = [NSString stringWithFormat:@"%@?", httpRequest.url.absoluteString];
    
    for(NSString *key in [httpRequest.parameters allKeys]) {
        urlString = [NSString stringWithFormat:@"%@%@=%@&", urlString, key, [httpRequest.parameters objectForKey:key]];
    }
    
    urlString = [urlString substringWithRange:NSMakeRange(0, [urlString length]-1)];

    NSURL *requestURL = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[httpRequest.timeoutInterval floatValue]];

    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *requestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (!requestConnection ) {
        
        [self.delegate request:httpRequest didFailWithError:[NSError errorWithDomain:@"Request Error" code:1 userInfo:nil]];
    }
    
    CFDictionaryAddValue(self.connectionData, (__bridge const void *)(requestConnection), (__bridge const void *)(httpRequest));

}

#pragma mark - POST Interface
// TODO
- (void)postRequest:(HTTPRequest *)httpRequest {
    
    NSString *urlString = [NSString stringWithFormat:@"%@?", httpRequest.url];
    
    for(NSString *key in [httpRequest.parameters allKeys]) {
        urlString = [NSString stringWithFormat:@"%@%@=%@&", urlString, key, [httpRequest.parameters objectForKey:key]];
    }
    
    urlString = [urlString substringWithRange:NSMakeRange(0, [urlString length]-1)];
    
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:[httpRequest.timeoutInterval floatValue]];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *requestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    if (!requestConnection ) {
    }
    
    CFDictionaryAddValue(self.connectionData, (__bridge const void *)(requestConnection), (__bridge const void *)(httpRequest));

}


#pragma mark - NSURLConnectionDelegate Protocol Implementation

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    HTTPRequest *httpRequest = (__bridge HTTPRequest *)(CFDictionaryGetValue(self.connectionData, (__bridge const void *)(connection)));
    
    for (id target in [httpRequest.HTTPRequestEventDidBeginLoadingDictionary allKeys]) {
        SEL action = NSSelectorFromString([httpRequest.HTTPRequestEventDidBeginLoadingDictionary objectForKey:target]);
        objc_msgSend(target, action);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    HTTPRequest *httpRequest = (__bridge HTTPRequest *)(CFDictionaryGetValue(self.connectionData, (__bridge const void *)(connection)));

    [httpRequest.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    HTTPRequest *httpRequest = (__bridge HTTPRequest *)(CFDictionaryGetValue(self.connectionData, (__bridge const void *)(connection)));
    HTTPResponse *httpResponse = [[HTTPResponse alloc] initWithRequest:httpRequest];

    for (id target in [httpRequest.HTTPRequestEventDidFinishLoadingDictionary allKeys]) {
        SEL action = NSSelectorFromString([httpRequest.HTTPRequestEventDidFinishLoadingDictionary objectForKey:target]);
        objc_msgSend(target, action, httpResponse);
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    HTTPRequest *httpRequest = (__bridge HTTPRequest *)(CFDictionaryGetValue(self.connectionData, (__bridge const void *)(connection)));
    [self.delegate request:httpRequest didFailWithError:error];
    
    for (id target in [httpRequest.HTTPRequestEventDidFailToLoadDictionary allKeys]) {
        SEL action = NSSelectorFromString([httpRequest.HTTPRequestEventDidFailToLoadDictionary objectForKey:target]);
        objc_msgSend(target, action, error);
    }
}

@end





