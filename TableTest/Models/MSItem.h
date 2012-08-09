//
//  MSItem.h
//  TableTest
//
//  Created by Matt Langtree on 9/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kItemImageDidLoadNotification;

@interface MSItem : NSObject

@property (readonly) NSUInteger tweetID;
@property (readonly) NSString *text;
@property (unsafe_unretained, readonly) NSURL *itemImageURL;
@property (nonatomic, strong) NSImage *itemImage;

+ (NSOperationQueue *)sharedItemImageRequestOperationQueue;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)publicTimelineItemsWithBlock:(void (^)(NSArray *tweets))block;

@end
