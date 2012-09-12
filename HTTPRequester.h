

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>
#import "HTTPRequest.h"
#import "HTTPResponse.h"

@protocol HTTPRequesterDelegate <NSObject>

- (void)didRespond:(HTTPResponse *)response;
- (void)request:(HTTPRequest *)request didFailWithError:(NSError *)error;

@end


@interface HTTPRequester : NSObject <NSURLConnectionDelegate>

@property (nonatomic, weak) id <HTTPRequesterDelegate> delegate;


+ (id)sharedInstance;
- (void)getRequest:(HTTPRequest *)httpRequest;
- (void)postRequest:(HTTPRequest *)httpRequest;

@end
