//
//  DBFileViewController.m
//  
//
//  Created by Sheen on 10/6/15.

//



#import "DBFileViewController.h"
#import "DropboxLister.h"
#import "DropboxFolderCellView.h"
#import "DBProgressController.h"


@interface DBFileViewController ()  <NSTableViewDataSource,NSTableViewDelegate>


@property (nonatomic,retain) DropboxLister *lister;
@property (nonatomic,retain) NSArray *items;

@property(nonatomic,assign) IBOutlet NSTableView *tableView;
@property(nonatomic,assign) IBOutlet DBProgressController *progressController;
@property(nonatomic,assign) IBOutlet NSButton *backButton;


@end

@implementation DBFileViewController


@synthesize lister;
@synthesize items;

@synthesize progressController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
     [self updateBackButton];
   
    
}

-(void)updateBackButton{
    
    if(self.lister.currentPath == nil || [self.lister.currentPath isEqualToString:@"/"]){
        [self.backButton setHidden:YES];
    }
    else{
        [self.backButton setHidden:NO];
    }
    
}

-(void)load{
    
    self.lister = [DropboxLister new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.progressController showProgrss];
    [self.lister listItems:nil complectionBlock:^(NSArray *dbFiles) {
        self.items = dbFiles;
        [self.tableView deselectAll:nil];
        [self.tableView reloadData];
        [self.progressController stopProgress];
        [self updateBackButton];
    }];

}

-(void)reset{
    
    self.items = nil;
    [self.tableView reloadData];
    
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    self.lister = nil;
}

- (void)dealloc
{
    
    self.lister = nil;
    self.items = nil;
   
    [super dealloc];
}

-(IBAction)back:(id)sender{
    [self.progressController showProgrss];
    [self.lister listParent:^(NSArray *dbFiles) {
         self.items = dbFiles;
        
         [self.tableView reloadData];
        [self.progressController stopProgress];
         [self updateBackButton];
    }];
   
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSInteger row = self.tableView.selectedRow;
    
    if( row > -1){
    
    DBMetadata *data = [self.items objectAtIndex:row];
    
    if (data.isDirectory == YES) {
        
          [self.progressController showProgrss];
        [self.lister listItems:data.path complectionBlock:^(NSArray *dbFiles) {
            self.items = dbFiles;
            [self.tableView reloadData];
             [self updateBackButton];
            [self.progressController stopProgress];
        }];

        
    }
    }
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.items.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
 
    DropboxFolderCellView *returnView = [self.tableView makeViewWithIdentifier:@"DropboxFolderCellView" owner:self];
    DBMetadata *data = [self.items objectAtIndex:row];
    
    returnView.textField.stringValue = data.path.lastPathComponent;
    returnView.iconView.image = [NSImage imageNamed:data.icon];
    
    
    return returnView;
}

@end
