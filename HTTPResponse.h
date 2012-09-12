//
//  HTTPResponse.h
//  crowdshout
//
//  Created by David Muir on 9/11/12.
//  Copyright (c) 2012 crowdshout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPRequest.h"

@interface HTTPResponse : NSObject

- (id)initWithRequest:(HTTPRequest *)request;

- (NSDictionary *)jsonDictionaryValue;
- (NSString *)stringValue;
- (UIImage *)imageValue;

@end
