//
//  DBProgressController.h
//
//  Created by Sheen on 10/6/15.

#import <Cocoa/Cocoa.h>
#import <DropboxOSX/DropboxOSX.h>


@interface DBProgressController : NSObject
{
    
    IBOutlet NSView *view;
    IBOutlet NSProgressIndicator *progressIndicator;
    IBOutlet NSView *parentView;
}


//show the progress in parent View
- (void)showProgrss;
// remove the progress from parent view
- (void)stopProgress;

@end


