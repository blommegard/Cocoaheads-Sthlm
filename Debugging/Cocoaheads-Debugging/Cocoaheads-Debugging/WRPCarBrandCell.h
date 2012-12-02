//
//  WRPCarBrandCell.h
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-12-02.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const WRPCarBrandCellIdentifier;

@class WRPCarBrand;

@interface WRPCarBrandCell : UITableViewCell
@property (nonatomic, strong) WRPCarBrand *brand;
@end
