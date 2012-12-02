//
//  WRPViewController.m
//  Cocoaheads-Debugging
//
//  Created by Simon Blommegård on 2012-11-26.
//  Copyright (c) 2012 Wrapp. All rights reserved.
//

#import "WRPViewController.h"
#import "WRPCarBrand.h"
#import "WRPCarBrandCell.h"

@interface WRPViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *brands;
@end

@implementation WRPViewController

- (BOOL)shouldAutorotate {
  return NO;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self currentProccessNameString];
  
  NSString *name = @"Hejhopp";
  [self setTitle:name];
  
  [self.view addSubview:self.tableView];
  
  
  NSMutableArray *array = [NSMutableArray array];
  
  [[self brandNamesFromFile] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
    WRPCarBrand *brand = [WRPCarBrand new];
    [brand setName:name];
    [brand setImageName:[NSString stringWithFormat:@"car%d", (idx%3+1)]];
    [array addObject:brand];
  }];
  
  
  [self setBrands:array];
  
  [self.tableView reloadData];
}

#pragma mark - Properties

- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setRowHeight:200.f];
    
    [_tableView registerClass:[WRPCarBrandCell class] forCellReuseIdentifier:WRPCarBrandCellIdentifier];
  }
  return _tableView;
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.brands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  WRPCarBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:WRPCarBrandCellIdentifier
                                                          forIndexPath:indexPath];
  
  [cell setBrand:self.brands[indexPath.row]];
  
  return cell;
}

#pragma mark -

- (NSArray *)brandNamesFromFile {
  return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Car Brands" ofType:@"plist"]];
}

- (NSString *)currentProccessNameString {
  return [[NSProcessInfo processInfo] processName];
}

@end
