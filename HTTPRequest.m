//
//  HTTPRequest.m
//  FratQuest
//
//  Created by Tyler Nettleton on 9/10/12.
//  Copyright (c) 2012 Tyler Nettleton. All rights reserved.
//

#import "HTTPRequest.h"

#define DEFAULT_TIMEOUT_INTERVAL 60.0

@interface HTTPRequest ()


@end

@implementation HTTPRequest

- (id)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        
        _url = url;
        
        _responseData = [[NSMutableData alloc] init];
        _parameters = [[NSMutableDictionary alloc] init];
        
        _HTTPRequestEventDidBeginLoadingDictionary = [[NSMutableDictionary alloc] init];
        _HTTPRequestEventDidFinishLoadingDictionary = [[NSMutableDictionary alloc] init];
        _HTTPRequestEventDidFailToLoadDictionary = [[NSMutableDictionary alloc] init];
        
        _headers = [[NSMutableDictionary alloc] init];
        
        _timeoutInterval = [NSNumber numberWithFloat:DEFAULT_TIMEOUT_INTERVAL];

    }
    return self;
}


- (void)addHeader:(NSString *)headerType headerValue:(NSString *)value {
    [self.headers setValue:value forKey:headerType];
}

- (void)addParameterWithKey:(NSString *)key value:(NSString *)value {
    [self.parameters setObject:value forKey:key];
}

- (void)addTarget:(id)target action:(SEL)selector forEvent:(HTTPRequestEvent)event {
    
    switch (event) {
        case HTTPRequestEventDidBeginLoading:
            CFDictionaryAddValue((__bridge CFMutableDictionaryRef)(self.HTTPRequestEventDidBeginLoadingDictionary), (__bridge const void *)(target), (__bridge const void *)(NSStringFromSelector(selector)));
            break;
        case HTTPRequestEventDidFinishLoading:
            CFDictionaryAddValue((__bridge CFMutableDictionaryRef)(self.HTTPRequestEventDidFinishLoadingDictionary), (__bridge const void *)(target), (__bridge const void *)(NSStringFromSelector(selector)));
            break;
        case HTTPRequestEventDidFailToLoad:
            CFDictionaryAddValue((__bridge CFMutableDictionaryRef)(self.HTTPRequestEventDidFailToLoadDictionary), (__bridge const void *)(target), (__bridge const void *)(NSStringFromSelector(selector)));
            break;
        default:
            break;
    }
}


@end
