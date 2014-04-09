//
//  SBViewController.m
//  Cocoaheads-CVCT
//
//  Created by Simon Blommegård on 2014-04-07.
//  Copyright (c) 2014 Simon Blommegård. All rights reserved.
//

#import "SBViewController.h"

@interface SBViewController ()

@end

@implementation SBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  NSString *screen = NSStringFromClass(self.class);
  
  NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"^SB(.+)ViewController$" options:0 error:NULL];
  NSTextCheckingResult *result = [expression firstMatchInString:screen options:0 range:NSMakeRange(0, screen.length)];
  
  if (result.numberOfRanges > 1)
    [self setTitle:[screen substringWithRange:[result rangeAtIndex:1]]];
}

@end
