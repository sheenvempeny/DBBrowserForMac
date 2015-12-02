//
//  DropboxLister.h
//
//
//  Created by Sheen on 10/5/15.

#import <Foundation/Foundation.h>
#import "RestClient.h"


typedef void (^DropboxListCompletionBlock) (NSArray *dbFiles);

@interface DropboxLister : RestClient
{
    
    
    
}

@property(nonatomic,readonly,retain) NSString *currentPath;
// list the items in the path with completion block
- (void) listItems:(NSString*)path complectionBlock:(DropboxListCompletionBlock)block;
//list the parent items
- (void) listParent:(DropboxListCompletionBlock)block;

@end
