//
//  MUAppDelegate.m
//  TableTest
//
//  Created by Matt Langtree on 2/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import "MUAppDelegate.h"

@implementation MUAppDelegate
@synthesize window = _window;
@synthesize recordTableView;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)awakeFromNib
{
    [recordTableView setAllowsColumnSelection:NO];
    [recordTableView setUsesAlternatingRowBackgroundColors:YES];
    [recordTableView setRowHeight:70];
    [recordTableView setHeaderView:nil];
    [recordTableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)application
                    hasVisibleWindows:(BOOL)flag
{
    [self.window makeKeyAndOrderFront:self];
    
    return YES;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return 6;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 70;
}

- (NSString *)tableView:(NSTableView *)tableView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation
{
    return @"You are a banana head";
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return @"This is a test.";
}

@end
