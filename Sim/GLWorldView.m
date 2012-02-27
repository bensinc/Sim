//
//  GLWorldView.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "GLWorldView.h"
#import "GLUT/glut.h"

#define LIGHT_X_TAG 0
#define THETA_TAG 1
#define RADIUS_TAG 2

@implementation GLWorldView

@synthesize world;

-(void)prepare {
    NSLog(@"Prepare!");
    
    NSOpenGLContext *glContext = [self openGLContext];
    [glContext makeCurrentContext];
    
    glShadeModel(GL_SMOOTH);
    glEnable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
    
    
    GLfloat ambient[] = {0.2, 0.2, 0.2, 1.0};
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient);
    
    
    GLfloat diffuse[] = {1.0, 1.0, 1.0, 1.0};
    glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
    
    glEnable(GL_LIGHT0);
    
    GLfloat mat[] = {01, 0.1, 0.7, 1.0};
    glMaterialfv(GL_FRONT, GL_AMBIENT, mat);
    
    glMaterialfv(GL_FRONT, GL_DIFFUSE, mat);
    
}

-(id)initWithCoder:(NSCoder *)c {
    self = [super initWithCoder:c];
    if (self)
        [self prepare];    
    return(self);        
}

-(void)reshape {
    NSLog(@"Reshaping!");
    NSRect baseRect = [self convertRectToBase:[self bounds]];
    
    glViewport(0, 0, baseRect.size.width, baseRect.size.height);
    glMatrixMode(GL_PROJECTION);
    

    
    glLoadIdentity();
    gluPerspective(60.0, baseRect.size.width/baseRect.size.height, 0.2, 27);    
    

}

-(void)awakeFromNib {
    [self changeParameter:self];
}

-(IBAction)changeParameter:(id)sender {
//    NSLog(@"Change parameter!");
    lightX = [[sliderMatrix cellWithTag:LIGHT_X_TAG] floatValue];
    theta = [[sliderMatrix cellWithTag:THETA_TAG] floatValue];
    radius = [[sliderMatrix cellWithTag:RADIUS_TAG] floatValue];
    [self setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)r {
    
    glClearColor(0.2, 0.4, 0.1, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(radius * sin(theta), 0, radius * cos(theta),
              0, 0, 0,
              0, 1, 0);
    
    GLfloat lightPosition[] = {lightX, 1, 3, 0.0};
    glLightfv(GL_LIGHT0, GL_POSITION, lightPosition);
    
    if (!displayList) {
        displayList = glGenLists(1);
        glNewList(displayList, GL_COMPILE_AND_EXECUTE);
        
//        glTranslatef(0, 0, 0);
//        glutSolidTorus(0.3, 0.9, 35, 31);
//        
//        glTranslatef(0, 0, -1.2);
//        glutSolidCone(1, 1, 17, 17);
//        
//        glTranslatef(0, 0, 0.6);
//        glutSolidTorus(0.3, 1.8, 35, 31);

        for (Program *p in world.programs) {
            NSLog(@"Program at: %i, %i", p.x, p.y);
            glTranslatef(p.x/100.0 * 1.0, p.y/100.0 * 1.0, 0);
            
            
            glMatrixMode(GL_COLOR);
            
            glColor3d(100.0, 100.0, 100.0);
            
            glMatrixMode(GL_MODELVIEW);

//            glutSolidSphere(0.1, 10, 10);
            
            glutSolidCube(0.1);            

            
        }
        
        for (int x = 0; x < 100; x++) {
            for (int y = 0; y < 100; y++) {
                if ([world objectAtX:x Y:y] == 1) {
                    NSLog(@"Resource at: %i, %i", x, y);
                    glTranslatef(x/100.0, y/100.0, 0);
                    glutSolidSphere(0.1, 10, 10);
                }
            }
        }
        
        glEndList();                
    } else {
        
        glCallList(displayList);
    }
    
    glFinish();
    
}


@end
