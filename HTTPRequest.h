//
//  HTTPRequest.h
//  FratQuest
//
//  Created by Tyler Nettleton on 9/10/12.
//  Copyright (c) 2012 Tyler Nettleton. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HTTPRequestEventDidBeginLoading,
    HTTPRequestEventDidFinishLoading,
    HTTPRequestEventDidFailToLoad
    
} HTTPRequestEvent;


@interface HTTPRequest : NSObject

@property (nonatomic, strong) NSURLConnection *requestConnection;
@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSNumber *timeoutInterval;


@property (nonatomic, strong) NSMutableDictionary *HTTPRequestEventDidBeginLoadingDictionary;
@property (nonatomic, strong) NSMutableDictionary *HTTPRequestEventDidFinishLoadingDictionary;
@property (nonatomic, strong) NSMutableDictionary *HTTPRequestEventDidFailToLoadDictionary;

@property (nonatomic, strong) NSMutableDictionary *parameters;

@property (nonatomic, strong) NSMutableDictionary *headers;


- (id)initWithURL:(NSURL *)url;
- (void)addParameterWithKey:(NSString *)key value:(NSString *)value;

- (void)addTarget:(id)target action:(SEL)selector forEvent:(HTTPRequestEvent)event;

- (void)addHeader:(NSString *)headerType headerValue:(NSString *)value;

@end
