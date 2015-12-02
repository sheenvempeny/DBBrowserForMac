//
//  DBFileViewController.m
//
//
//  Created by Sheen on 10/6/15.

//


#import "DBProgressController.h"

@interface DBProgressController ()


@end

@implementation DBProgressController

- (void)showProgrss{
    
    if(!view.window){
        
        CALayer *viewLayer = [CALayer layer];
        [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)]; //RGB plus Alpha Channel
        [view setWantsLayer:YES]; // view's backing store is using a Core Animation Layer
        viewLayer.cornerRadius = 5.0;
        [view setLayer:viewLayer];
        
        CGRect parentFrame = parentView.frame;
        CGRect viewFrame = view.frame;
        viewFrame.origin.x = (parentFrame.size.width - viewFrame.size.width)/2.0;
        viewFrame.origin.y = (parentFrame.size.height - viewFrame.size.height)/2.0;
        view.frame = viewFrame;
        
        [parentView addSubview:view];

    }
    [progressIndicator startAnimation:nil];
    
}
- (void)stopProgress{
    
     [progressIndicator stopAnimation:nil];
    [view removeFromSuperview];
}



@end
