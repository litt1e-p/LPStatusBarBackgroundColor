//
//  ViewController.m
//  LPStatusBarBackgroundColorSample
//
//  Created by litt1e-p on 16/1/7.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+StatusBarColor.h"

typedef NS_ENUM(NSInteger, StatusColor)
{
    StatusColorBlack,
    StatusColorGreen,
    StatusColorRed,
    StatusColorBlue,
    StatusColorGray,
    StatusColorBrown
};

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation ViewController

static NSString * const kCellID = @"kCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.textLabel.text = [self configureCellColorDesc:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.navigationBar.statusBarBackgroundColor = [self configureCellColor:indexPath.row];
}

- (NSString *)configureCellColorDesc:(StatusColor)row
{
    switch (row) {
        case StatusColorGreen:
            return @"green";
            break;
        case StatusColorRed:
            return @"red";
            break;
        case StatusColorBlue:
            return @"blue";
            break;
        case StatusColorGray:
            return @"gray";
            break;
        case StatusColorBrown:
            return @"brown";
            break;
        default:
            return @"black";
            break;
    }
}

- (UIColor *)configureCellColor:(StatusColor)row
{
    switch (row) {
        case StatusColorGreen:
            return [UIColor greenColor];
            break;
        case StatusColorRed:
            return [UIColor redColor];
            break;
        case StatusColorBlue:
            return [UIColor blueColor];
            break;
        case StatusColorGray:
            return [UIColor grayColor];
            break;
        case StatusColorBrown:
            return [UIColor brownColor];
            break;
        default:
            return [UIColor blackColor];
            break;
    }
}

@end
