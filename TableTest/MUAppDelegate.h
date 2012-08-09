//
//  MUAppDelegate.h
//  TableTest
//
//  Created by Matt Langtree on 2/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MUAppDelegate : NSObject <NSApplicationDelegate,NSTableViewDataSource,NSTableViewDelegate>

@property (strong) IBOutlet NSWindow *window;

@property (strong) NSStatusItem *statusItem;

@property (unsafe_unretained) IBOutlet NSTabView *tabView;

@property (strong) IBOutlet NSArrayController *itemsArrayController;

@property (strong) IBOutlet NSSegmentedControl *segmentedControl;

@property (unsafe_unretained) IBOutlet NSTableView *recordTableView;

@property (unsafe_unretained) IBOutlet NSImageView *thumbnailImageView;

- (IBAction)segControlClicked:(id)sender;

@end
