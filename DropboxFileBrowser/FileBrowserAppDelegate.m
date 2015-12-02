//
//  FileBrowserAppDelegate.m
//  FileBrowser

#import "FileBrowserAppDelegate.h"
#import "FileBrowserWindowController.h"

@implementation FileBrowserAppDelegate

@synthesize windowController = windowController_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{		
	[[[self windowController] window] makeKeyAndOrderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
}

@end
