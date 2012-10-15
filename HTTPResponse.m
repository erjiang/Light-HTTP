//
//  HTTPResponse.m
//  crowdshout
//
//  Created by David Muir on 9/11/12.
//  Copyright (c) 2012 crowdshout. All rights reserved.
//

#import "HTTPResponse.h"

@interface HTTPResponse ()

@property (nonatomic, strong) HTTPRequest *request;

@end

@implementation HTTPResponse

- (id)initWithRequest:(HTTPRequest *)request {
    self = [super init];
    if(self) {
        self.request = request;
    }
    return self;
}

- (NSArray *)jsonArrayValue {
    NSError *error;
    NSArray *array;
    
    id serialized = [NSJSONSerialization JSONObjectWithData:self.request.responseData options:kNilOptions error:&error];
    
    if([serialized isKindOfClass:[NSArray class]]) {
        array = serialized;
    }
    else if([serialized isKindOfClass:[NSDictionary class]]) {
        array = [NSArray arrayWithObject:serialized];
    }
    
    
    if(error) {
        return nil;
    }
    else {
        return array;
    }
}

- (NSString *)stringValue {
    return [[NSString alloc] initWithData:self.request.responseData encoding:NSUTF8StringEncoding];
}

- (UIImage *)imageValue {
    return [[UIImage alloc] initWithData:self.request.responseData];
}

@end
