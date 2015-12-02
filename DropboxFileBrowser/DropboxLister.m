//
//  DropboxLister.m
//
//
//  Created by Sheen on 10/5/15.


#import "DropboxLister.h"

@interface DropboxLister()

@property (nonatomic,copy) DropboxListCompletionBlock completionBlock;
@property (nonatomic,retain) NSArray *items;

@end


@implementation DropboxLister

@synthesize completionBlock;
@synthesize items;


- (void)listItems:(NSString*)path complectionBlock:(DropboxListCompletionBlock)block{
    
    self.completionBlock = block;
    
    if(path == nil){
        path = @"/";
    }
    _currentPath = [path retain];
    [self.restClient loadMetadata:path];
    
}

- (void)dealloc
{
    [_currentPath release];
    [super dealloc];
}

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata{
    
    self.completionBlock(metadata.contents);
}


-(void)listParent:(DropboxListCompletionBlock)block{
    
    NSString *parent = self.currentPath.stringByDeletingLastPathComponent;
    if (![parent isEqualToString:self.currentPath]) {
        [self listItems:parent complectionBlock:block];
    }
    
}

-(BOOL) hasParent{

    BOOL returnStatus = NO;
    if (self.currentPath.pathComponents.count > 1) {
        returnStatus = YES;
    }
    
    return returnStatus;
}


@end
