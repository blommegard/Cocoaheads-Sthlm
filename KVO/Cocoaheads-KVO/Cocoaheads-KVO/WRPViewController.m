//
//  WRPViewController.m
//  Cocoaheads-KVO
//
//  Created by Simon Blommegård on 2012-10-28.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPViewController.h"
#import "WRPPerson.h"

@interface WRPViewController ()
@property (nonatomic, strong) WRPPerson *person;
@end

@implementation WRPViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [WRPPerson setValueTest];
    [WRPPerson keyPathTest];
    
    [self setPerson:[WRPPerson new]];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.person addObserver:self
                forKeyPath:@"age"
                   options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial)
                   context:NULL];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2. * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
    [self.person setAge:20];
  });
}

- (void)dealloc {
  [self.person removeObserver:self forKeyPath:@"age" context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if ([keyPath isEqualToString:@"age"]) {
    
    [self.ageLabel setText:[NSString stringWithFormat:@"%@", change[NSKeyValueChangeNewKey]]];
    
    NSLog(@"%@", [object observationInfo]);
  } else
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (IBAction)downUpAction:(id)sender {
  if (sender == self.downButton)
    self.person.age--;
  else
    self.person.age++;
}

@end
