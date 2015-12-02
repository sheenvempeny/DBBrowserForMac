//
//  DBFileViewController.m
//
//  Created by Sheen on 10/6/15.

//



#define APP_KEY @"361ojw2jsjd9d8c"
#define APP_SECRET @"oxwfaha1zgf5cru"

#import "DBLoginController.h"

@interface DBLoginController ()

@property (nonatomic, retain) NSString *requestToken;

-(void) updateLoginStatus;
-(void) initDropBox:(NSWindow*)window;

@property (nonatomic,copy) DropboxLoginCompletionBlock  inCompletionBlock;

@end

@implementation DBLoginController

@synthesize requestToken;
@synthesize loginStatus;
@synthesize inCompletionBlock;

- (void)dealloc
{
    self.requestToken = nil;
    self.inCompletionBlock = nil;
    
    [super dealloc];
}

- (instancetype)initWithWindow:(NSWindow*)window
{
    self = [super init];
    if (self) {
        [self initDropBox:window];
    }
    return self;
}

-(void)initDropBox:(NSWindow*)window{
    
    NSString *appKey = APP_KEY;
    NSString *appSecret = APP_SECRET;
    NSString *root = kDBRootDropbox; // Should be either kDBRootDropbox or kDBRootAppFolder
    DBSession *session = [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
    [DBSession setSharedSession:session];
    
    NSDictionary *plist = [[NSBundle mainBundle] infoDictionary];
    NSString *actualScheme = [[[[plist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
    NSString *desiredScheme = [NSString stringWithFormat:@"db-%@", appKey];
    NSString *alertText = nil;
    if ([appKey isEqual:@"APP_KEY"] || [appSecret isEqual:@"APP_SECRET"] || root == nil) {
        alertText = @"Fill in appKey, appSecret, and root in AppDelegate.m to use this app";
    } else if (![actualScheme isEqual:desiredScheme]) {
        alertText = [NSString stringWithFormat:@"Set the url scheme to %@ for the OAuth authorize page to work correctly", desiredScheme];
    }
    
    if (alertText) {
        NSAlert *alert = [NSAlert alertWithMessageText:nil defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@", alertText];
        [alert beginSheetModalForWindow:window modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authHelperStateChangedNotification:) name:DBAuthHelperOSXStateChangedNotification object:[DBAuthHelperOSX sharedHelper]];
    [self updateLoginStatus];
    
    NSAppleEventManager *em = [NSAppleEventManager sharedAppleEventManager];
    [em setEventHandler:self andSelector:@selector(getUrl:withReplyEvent:)
          forEventClass:kInternetEventClass andEventID:kAEGetURL];
    
}

- (void)updateLoginStatus{
    
    if ([[DBSession sharedSession] isLinked]) {
        loginStatus = linked;
    } else {
        
        loginStatus = [[DBAuthHelperOSX sharedHelper] isLoading] ? loading : notLinked;
    }
    
}

- (void)connect:(DropboxLoginCompletionBlock) completionBlock{
    
    
    if (self.loginStatus == notLinked) {
        self.inCompletionBlock = completionBlock;
        [[DBAuthHelperOSX sharedHelper] authenticate];
        
    }
    else{
        completionBlock(self.loginStatus);
    }
    
}
- (void)disconnect{
    
    if (self.loginStatus == linked) {
        [[DBSession sharedSession] unlinkAll];
        [self updateLoginStatus];
    }
    
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    // This gets called when the user clicks Show "App name". You don't need to do anything for Dropbox here
}

#pragma mark private methods

- (void)authHelperStateChangedNotification:(NSNotification *)notification {
    [self updateLoginStatus];
    if ([[DBSession sharedSession] isLinked]) {
        // You can now start using the API!
       
    }
    
    self.inCompletionBlock(self.loginStatus);
}


@end
