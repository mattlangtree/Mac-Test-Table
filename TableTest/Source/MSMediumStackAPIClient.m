//
//  MSMediumStackAPIClient.m
//  TableTest
//
//  Created by Matt Langtree on 9/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import "MSMediumStackAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kMSMediumStackAPIBaseURLString = @"https://api.mediumstack.com/v1/";

@implementation MSMediumStackAPIClient

+ (MSMediumStackAPIClient *)sharedClient {
    static MSMediumStackAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MSMediumStackAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kMSMediumStackAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}


@end
