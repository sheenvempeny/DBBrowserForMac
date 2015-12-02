//
//  FileBrowserWindowController.m
//  FileBrowser
//

#import "FileBrowserWindowController.h"
#import "DBLoginController.h"
#import "DBFileViewController.h"
#import "DBProgressController.h"

@interface FileBrowserWindowController()
-(void) updateLinkButton;
@property(nonatomic,retain) DBFileViewController *dbFileViewController;
@property(nonatomic,retain) DBLoginController *dbLoginController;

@end



@implementation FileBrowserWindowController


- (void)awakeFromNib
{
	[super awakeFromNib];
    self.dbLoginController = [[DBLoginController alloc] initWithWindow:self.window];
    
    [self updateLinkButton];
     [self showDropBox:nil];
}

-(void)updateLinkButton{
    
    NSString *btnStr = @"Connect";
    if (self.dbLoginController.loginStatus == linked) {
        btnStr = @"DisConnect";
    }
    
    [btnbunLinkDB setTitle:btnStr];
}

- (void)dealloc
{
    self.dbFileViewController = nil;
    self.dbLoginController = nil;

    [super dealloc];
}

-(IBAction)connectDisconnect:(id)sender{
    
    if (self.dbLoginController.loginStatus == linked) {
        [self disconnectDB:nil];
    }
    else{
        [self showDropBox:nil];
    }
}

-(IBAction)showDropBox:(id)sender{
    
    [self.dbLoginController connect:^(EDropboxLogin loginStatus) {
        
        if (loginStatus == linked) {
            
            if(!self.dbFileViewController){
                self.dbFileViewController = [[DBFileViewController alloc] initWithNibName:@"DBFileViewController" bundle:[NSBundle mainBundle]];
                
            }
            
            if (!self.dbFileViewController.view.window) {
                
                [self.dbFileViewController load];
                [boxContainer setContentView:self.dbFileViewController.view];

            }
        }
        
        [self updateLinkButton];
    }];
    
}

-(IBAction)disconnectDB:(id)sender{
    
    [self.dbLoginController disconnect];
    [self updateLinkButton];
    [boxContainer setContentView:nil];
}


@end
