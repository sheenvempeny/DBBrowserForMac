//
//  DBLoginController.h
//
//
//  Created by Sheen on 10/6/15.
//  

#import <Cocoa/Cocoa.h>
#import <DropboxOSX/DropboxOSX.h>

typedef enum{
    
    notLinked = 0,
    linked = 1,
    loading = 3
    
}EDropboxLogin;

typedef void (^DropboxLoginCompletionBlock) (EDropboxLogin loginStatus);

@interface DBLoginController : NSObject
{
    
    
    
}

@property(nonatomic,readonly) EDropboxLogin loginStatus;
//init with window for dropbox Login
- (instancetype)initWithWindow:(NSWindow*)window;
//connect dropbox with completion block
- (void)connect:(DropboxLoginCompletionBlock) completionBlock;
//disconnect dropbox
- (void)disconnect;

@end


