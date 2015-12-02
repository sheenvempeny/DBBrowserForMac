//
//  FileBrowserWindowController.h
//  FileBrowser


#import <Cocoa/Cocoa.h>

@interface FileBrowserWindowController : NSWindowController
{
	IBOutlet NSButton *btnbunLinkDB;
    IBOutlet NSBox *boxContainer;
}



-(IBAction)connectDisconnect:(id)sender;

@end


