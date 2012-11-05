//
//  WRPPerson.m
//  Cocoaheads-KVO
//
//  Created by Simon Blommegård on 2012-10-28.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPPerson.h"

@implementation WRPPerson

#pragma mark - Properties

- (NSString *)fullName {
  return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (void)setAge:(NSInteger)age {
  if (_age != age) {
    [self willChangeValueForKey:@"age"];
    _age = age;
    [self didChangeValueForKey:@"age"];
  }
}

#pragma mark - KVO

+ (NSSet *)keyPathsForValuesAffectingFullName {
  return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

+ (BOOL)automaticallyNotifiesObserversOfAge {
  return NO;
}

#pragma mark - Tests

+ (void)setValueTest {
  WRPPerson *person = [WRPPerson new];
  NSString *key = @"firstName";
  
  [person setValue:@"Simon" forKey:key];
  NSString *value = [person valueForKey:key];

  NSLog(@"%@ : %@", key, value);
}

+ (void)keyPathTest {
  WRPPerson *simon = [WRPPerson new];
  [simon setAge:20];
  [simon setFirstName:@"Simon"];
  
  WRPPerson *greg = [WRPPerson new];
  [greg setAge:24];
  [greg setFirstName:@"Greg"];
  [greg setBestFriend:simon];
  
  NSLog(@"Gregs best friend : %@", [greg valueForKeyPath:@"bestFriend.firstName"]);
  
  NSArray *persons = @[simon, greg];
  NSLog(@"Avg. age : %@", [persons valueForKeyPath:@"@avg.age"]);
}

@end
