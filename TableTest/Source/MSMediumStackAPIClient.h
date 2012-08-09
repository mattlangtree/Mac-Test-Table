//
//  MSMediumStackAPIClient.h
//  TableTest
//
//  Created by Matt Langtree on 9/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import "AFHTTPClient.h"

@interface MSMediumStackAPIClient : AFHTTPClient

+ (MSMediumStackAPIClient *)sharedClient;

@end
