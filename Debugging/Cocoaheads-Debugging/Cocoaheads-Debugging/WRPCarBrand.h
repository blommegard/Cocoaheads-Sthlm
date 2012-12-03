//
//  WRPCarBrand.h
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-12-03.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WRPCarBrand : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageName;

@end
