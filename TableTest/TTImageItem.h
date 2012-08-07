//
//  TTImageItem.h
//  TableTest
//
//  Created by Matt Langtree on 7/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTImageItem : NSObject
{
    NSString *imageURL;
    NSString *imageTitle;
}

@property (readwrite, copy) NSString *imageURL;
@property (readwrite, copy) NSString *imageTitle;

@end
