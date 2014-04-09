//
//  SBAppDelegate.m
//  Cocoaheads-CVCT
//
//  Created by Simon Blommegård on 2014-04-07.
//  Copyright (c) 2014 Simon Blommegård. All rights reserved.
//

#import "SBAppDelegate.h"

#import "SBFirstViewController.h"
#import "SBSecondViewController.h"

@interface SBAppDelegate () <UIViewControllerAnimatedTransitioning, UIGestureRecognizerDelegate>
@property (nonatomic) BOOL selectedToRight;
@end

@implementation SBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self.window makeKeyAndVisible];
  
  return YES;
}

#pragma mark - UITabBarControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
  
  [self setSelectedToRight:([tabBarController.viewControllers indexOfObject:toVC] > [tabBarController.viewControllers indexOfObject:fromVC])];
  
  return self;
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
  
  if (operation == UINavigationControllerOperationPush) {
    [self setSelectedToRight:YES];
    return self;
  }
  
  return nil; // Default action
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  [navigationController.interactivePopGestureRecognizer setDelegate:self]; // This is kind of hacky, for some reason Apple disables the interactive action as default when you implement navigationController:animationControllerForOperation:…
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
  return .6;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *view = [transitionContext containerView];
  
  CGRect initialFrom = [transitionContext initialFrameForViewController:fromVC];
  CGRect finalFrom = [transitionContext finalFrameForViewController:fromVC];
  CGRect initialTo = [transitionContext initialFrameForViewController:toVC];
  CGRect finalTo = [transitionContext finalFrameForViewController:toVC];
  
  NSArray *subViews = [view subviews];
  
  [toVC.view setTransform:CGAffineTransformMakeTranslation((CGRectGetWidth(finalTo) * (self.selectedToRight? 1 : -1)), 0)];
  
  [view addSubview:toVC.view];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext]
                        delay:0
       usingSpringWithDamping:.5
        initialSpringVelocity:.1
                      options:0 
                   animations:^{
                     
                     [toVC.view setTransform:CGAffineTransformIdentity];
                     
                   } completion:^(BOOL finished) {
                     [transitionContext completeTransition:finished];
                   }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  return YES;
}

@end
