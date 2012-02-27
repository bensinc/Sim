//
//  GLWorldView.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Cocoa/Cocoa.h>
#import "World.h"


@interface GLWorldView : NSOpenGLView {
    IBOutlet NSMatrix *sliderMatrix;
    float lightX, theta, radius;
    int displayList;
}

@property (nonatomic, retain) World *world;

-(IBAction)changeParameter:(id)sender;

@end
