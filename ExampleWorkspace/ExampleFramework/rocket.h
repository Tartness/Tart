// (c) 2017 Tartness

#ifndef ROCKET_H_
#define ROCKET_H_

#import <Foundation/Foundation.h>
// #import <UIKit/UIKit.h>
// #import <GLKit/GLKit.h>
// #import <CoreMedia/CoreMedia.h>

@interface Rocket : NSObject {
  // opaque pointer to hide cpp members from header and swift
  struct RocketOpaqueMembers *rocket_members_;
}

-(id) init;
-(void) dealloc;
-(int) getState;
-(void) toggleState;

@end
#endif // ROCKET_H_
