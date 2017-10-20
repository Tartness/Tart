// (c) 2017 Tartness

#include "rocket.h"

#include <fstream>
#include <iostream>
#include <functional>

#include <class-b.h>

struct RocketOpaqueMembers {
  ClassB class_b;
  int a = 1;
};

@implementation Rocket

int counter = 0;

-(id) init {
  self = [super init];
  if (self) {
    rocket_members_ = new RocketOpaqueMembers();
  }
  return self;
}

- (void) dealloc {
  // Free members
  delete rocket_members_;
}


-(void) toggleState {
  
}

-(int) getState {
  return 1;
}

@end
