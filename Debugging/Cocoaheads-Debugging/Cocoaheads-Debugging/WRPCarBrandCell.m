//
//  WRPCarBrandCell.m
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-12-02.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPCarBrandCell.h"
#import "WRPCarBrand.h"

NSString * const WRPCarBrandCellIdentifier = @"WRPCarBrandCellIdentifier";

@interface WRPCarBrandCell ()
@property (nonatomic, strong) UIImageView *brandImageView;
@property (nonatomic, strong) UILabel *brandLabel;
@end

@implementation WRPCarBrandCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    [self.contentView addSubview:self.brandImageView];
    [self.contentView addSubview:self.brandLabel];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  return self;
}

#pragma mark - Properties

- (void)setBrand:(WRPCarBrand *)brand {
  _brand = brand;

  [self.brandImageView setImage:[UIImage imageNamed:brand.imageName]];
  [self.brandLabel setText:brand.name];
  
  // Do something bad…
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    for (NSInteger i=0; i<50; i++)
      [self bad];
//  });
}

- (UIImageView *)brandImageView {
  if (!_brandImageView) {
    _brandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 157.f)];
  }
  return _brandImageView;
}

- (UILabel *)brandLabel {
  if (!_brandLabel) {
    _brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 150.f, 320.f, 50.f)];
    [_brandLabel setTextAlignment:NSTextAlignmentCenter];
    [_brandLabel setFont:[UIFont systemFontOfSize:18.f]];
    [_brandLabel setBackgroundColor:[UIColor clearColor]];
  }
  return _brandLabel;
}

#pragma mark - 

- (UIImage *)bad {
  UIImage *image = [UIImage imageNamed:@"bigImage"];
  
  CGSize size = CGSizeMake(roundf(image.size.width/2.f), roundf(image.size.height/2.f));
  UIGraphicsBeginImageContextWithOptions(size, NO, 1.f);
  
  [image drawInRect:CGRectMake(0.f, 0.f, size.width, size.height)];
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return newImage;
}

@end
