//
//  MSItem.m
//  TableTest
//
//  Created by Matt Langtree on 9/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import "MSItem.h"
#import "MSMediumStackAPIClient.h"
#import "AFImageRequestOperation.h"

NSString * const kItemImageDidLoadNotification = @"com.mediumstack.mac.item.image.loaded";

@implementation MSItem
{
@private
    NSUInteger _tweetID;
    __strong NSString *_text;
    __strong NSString *_itemThumbImageURLString;
    __strong NSString *_itemImageURLString;
    __strong AFImageRequestOperation *_itemImageRequestOperation;
}

@synthesize itemImage = _itemImage;
@synthesize tweetID = _tweetID;
@synthesize text = _text;

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _tweetID = [[attributes valueForKeyPath:@"id"] integerValue];
    _text = [attributes valueForKeyPath:@"label"];
    _itemThumbImageURLString = [attributes valueForKeyPath:@"image_thumb_src"];
    _itemImageURLString = [attributes valueForKeyPath:@"image_large_src"];
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"tweetID: %ld, text: %@",self.tweetID,self.text];
}

#pragma mark -

+ (void)publicTimelineItemsWithBlock:(void (^)(NSArray *tweets))block
{
    [[MSMediumStackAPIClient sharedClient] getPath:@"public_timeline/?session_key=s9pn6s13n3np90s6rpss693317o44rnp2pq614q0_4e995a16c9cb0" parameters:[NSDictionary dictionaryWithObject:@"false" forKey:@"include_entities"] success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSMutableArray *items = [JSON valueForKeyPath:@"item_list.items"];
        NSMutableArray *mutableItems = [NSMutableArray arrayWithCapacity:[items count]];
        for (NSDictionary *attributes in items) {
            MSItem *item = [[MSItem alloc] initWithAttributes:attributes];
            [mutableItems addObject:item];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableItems]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSAlert alertWithMessageText:NSLocalizedString(@"Error", nil)
                         defaultButton:NSLocalizedString(@"OK", nil)
                       alternateButton:nil
                           otherButton:nil
             informativeTextWithFormat:@"%@",[error localizedDescription]] runModal];
        
        if (block) {
            block(nil);
        }
    }];
}

- (NSURL *)itemThumbImageURL
{
    return [NSURL URLWithString:_itemThumbImageURLString];
}

- (NSURL *)itemImageURL
{
    return [NSURL URLWithString:_itemImageURLString];
}

+ (NSOperationQueue *)sharedItemImageRequestOperationQueue {
    static NSOperationQueue *_sharedItemImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedItemImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_sharedItemImageRequestOperationQueue setMaxConcurrentOperationCount:8];
    });
    
    return _sharedItemImageRequestOperationQueue;
}

- (NSImage *)itemImage {
	if (!_itemImage && !_itemImageRequestOperation) {
		_itemImageRequestOperation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:self.itemThumbImageURL] success:^(NSImage *image) {
			self.itemImage = image;
            
			_itemImageRequestOperation = nil;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kItemImageDidLoadNotification object:self userInfo:nil];
		}];
        
		[_itemImageRequestOperation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
			return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data userInfo:cachedResponse.userInfo storagePolicy:NSURLCacheStorageAllowed];
		}];
		
        [[[self class] sharedItemImageRequestOperationQueue] addOperation:_itemImageRequestOperation];
	}
	
	return _itemImage;
}


@end
