//
//  WRPViewController.h
//  Cocoaheads-KVO
//
//  Created by Simon Blommegård on 2012-10-28.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRPViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *ageLabel;
@property (nonatomic, strong) IBOutlet UIButton *downButton;
@property (nonatomic, strong) IBOutlet UIButton *upButton;

- (IBAction)downUpAction:(id)sender;
@end
