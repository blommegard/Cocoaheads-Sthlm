//
//  WRPPerson.h
//  Cocoaheads-KVO
//
//  Created by Simon Blommegård on 2012-10-28.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRPPerson : NSObject
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *fullName;

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) WRPPerson *bestFriend;

+ (void)setValueTest;
+ (void)keyPathTest;
@end
