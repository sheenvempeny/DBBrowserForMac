//
//  RestClient.m
//  

#import "RestClient.h"

@interface RestClient() <DBRestClientDelegate>
{
    DBRestClient *dbRestClient;
    NSString *revision;
    
}

@end


@implementation RestClient


-(DBRestClient*)restClient{
    
    if (dbRestClient == nil) {
        dbRestClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        dbRestClient.delegate = self;
    }

    return dbRestClient;
}

- (void)dealloc
{
    dbRestClient = nil;
    [super dealloc];
}

@end

