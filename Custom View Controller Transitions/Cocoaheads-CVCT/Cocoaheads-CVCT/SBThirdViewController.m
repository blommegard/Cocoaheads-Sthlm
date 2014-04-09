//
//  SBThirdViewController.m
//  Cocoaheads-CVCT
//
//  Created by Simon Blommegård on 2014-04-07.
//  Copyright (c) 2014 Simon Blommegård. All rights reserved.
//

#import "SBThirdViewController.h"
#import "SBFirstViewController.h"

@interface SBThirdViewController ()

@end

@implementation SBThirdViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    [self.view setBackgroundColor:[UIColor magentaColor]];
  } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor greenColor]];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
  [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(id)sender {
  [self.navigationController pushViewController:[SBFirstViewController new] animated:YES];
}

@end
