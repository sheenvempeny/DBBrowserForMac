//
//  FileBrowserAppDelegate.h
//  FileBrowser
//	

#import <Cocoa/Cocoa.h>

@class FileBrowserWindowController;
@interface FileBrowserAppDelegate : NSObject <NSApplicationDelegate> 
{
	
	FileBrowserWindowController *windowController_;
}

@property (assign) IBOutlet FileBrowserWindowController *windowController;

@end

