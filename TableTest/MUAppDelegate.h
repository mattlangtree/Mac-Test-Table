//
//  MUAppDelegate.h
//  TableTest
//
//  Created by Matt Langtree on 2/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MUAppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate>

@property (unsafe_unretained) IBOutlet NSTableView *recordTableView;

@property (strong) IBOutlet NSWindow *window;

@end
