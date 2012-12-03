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
#import "AFNetworking.h"

@interface WRPViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
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
  
  [[self brandNamesFromFile] enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
    WRPCarBrand *brand = [WRPCarBrand MR_createEntity];
    
    [brand setName:name];
    [brand setImageName:[NSString stringWithFormat:@"car%d", (idx%3+1)]];
  }];
  
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
  return [WRPCarBrand MR_findAll].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  WRPCarBrandCell *cell = [tableView dequeueReusableCellWithIdentifier:WRPCarBrandCellIdentifier
                                                          forIndexPath:indexPath];
  
  
  NSArray *brands = [WRPCarBrand MR_findAllSortedBy:@"name" ascending:YES];
  [cell setBrand:brands[indexPath.row]];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSURL *url = nil;
  if (indexPath.row%2 == 0)
    url = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&screen_name=blommegard&count=5"];
  else
    url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/en/thumb/e/ed/Nyan_cat_250px_frame.PNG/220px-Nyan_cat_250px_frame.PNG"];
    
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:nil failure:nil];
  [operation start];
}

#pragma mark -

- (NSArray *)brandNamesFromFile {
  return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Car Brands" ofType:@"plist"]];
}

- (NSString *)currentProccessNameString {
  return [[NSProcessInfo processInfo] processName];
}

@end
