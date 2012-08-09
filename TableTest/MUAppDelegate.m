//
//  MUAppDelegate.m
//  TableTest
//
//  Created by Matt Langtree on 2/08/12.
//  Copyright (c) 2012 Matt Langtree. All rights reserved.
//

#import "MUAppDelegate.h"
#import "MSItem.h"

@implementation MUAppDelegate
@synthesize window = _window;
@synthesize thumbnailImageView;
@synthesize itemsArrayController;
@synthesize segmentedControl;
@synthesize tabView;
@synthesize recordTableView;
@synthesize statusItem = _statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSStatusBar *bar = [NSStatusBar systemStatusBar];

    self.statusItem = [bar statusItemWithLength:NSSquareStatusItemLength];
    [_statusItem setTitle: NSLocalizedString(@"MS",@"")];
    [_statusItem setHighlightMode:YES];
    [_statusItem setTarget:self];
    [_statusItem setAction:@selector(statusItemClicked:)];

    // Fetch latest images.
    [MSItem publicTimelineItemsWithBlock:^(NSArray *items) {
        self.itemsArrayController.content = items;
    }];
    
    // When images come back from the server, update the tableview
    [[NSNotificationCenter defaultCenter] addObserverForName:kItemImageDidLoadNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        [recordTableView reloadData];
    }];
}

- (void)awakeFromNib
{
    [recordTableView setAllowsColumnSelection:NO];
    [recordTableView setUsesAlternatingRowBackgroundColors:YES];
    [recordTableView setRowHeight:70];
    [recordTableView setHeaderView:nil];
    [recordTableView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleSourceList];
    [recordTableView setTarget:self];
    [recordTableView setDoubleAction:@selector(doubleClick:)];

    // Show image tab by default
    [tabView selectTabViewItemAtIndex:1];

    // Handle user clicks on the segmented control
    [segmentedControl setAction:@selector(segControlClicked:)];
    
    [_window setTitle:@"Medium Stack — Images"];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)application
                    hasVisibleWindows:(BOOL)flag
{
    [self.window makeKeyAndOrderFront:self];
    
    return YES;
}

- (void)doubleClick:(id)object {
    NSInteger rowNumber = [recordTableView clickedRow];
    MSItem *rowItem = [self.itemsArrayController.content objectAtIndex:rowNumber];
    
    NSLog(@"row large image: %@",rowItem.itemImageURL);
    
    [[NSWorkspace sharedWorkspace] openURL:rowItem.itemImageURL];
}

//- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
//{
//    return 6;
//}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 70;
}

- (NSString *)tableView:(NSTableView *)tableView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation
{
    return @"You are a banana head";
}

//- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
//{
//    return @"This is a test.";
//}

- (IBAction)segControlClicked:(id)sender
{
    NSInteger clickedSegment = [sender selectedSegment];
    if (clickedSegment == 0) {
        [tabView selectTabViewItemAtIndex:1];
        [_window setTitle:@"Medium Stack — Images"];
    }
    else {
        [tabView selectTabViewItemAtIndex:2];
        [_window setTitle:@"Medium Stack — URLs"];
    }
}

#pragma mark - Status Bar item bits

-(void)statusItemClicked:(id)sender{
    NSWindow *aWindow = [self window];
    NSApplication *myApp = [NSApplication sharedApplication];
    
    if (![aWindow isKeyWindow]) {
        [aWindow makeKeyAndOrderFront:self];
        [myApp activateIgnoringOtherApps:YES];
        [aWindow orderFrontRegardless];
    }
    else{
        if ([myApp isActive]){
            // Hide the window
            [aWindow orderOut:sender];
        }
        else{
            // Display the window
            [myApp activateIgnoringOtherApps:YES];
            [aWindow orderFrontRegardless];
        }
    }
}


@end
