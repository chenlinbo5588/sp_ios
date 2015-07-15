//
//  MainTabBarViewController.m
//  sp
//
//  Created by Apple on 15-5-27.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MeMainTableViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"MainTabBarViewController");
    
    NSMutableArray *tabs = [NSMutableArray arrayWithCapacity:3];

    UIStoryboard *stroyMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MeMainTableViewController *basketBallTab = [stroyMain instantiateViewControllerWithIdentifier:@"BasketBallTabScene"];
    
    UIStoryboard *stroyMe = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    MeMainTableViewController *meTab = [stroyMe instantiateViewControllerWithIdentifier:@"MeScene"];
    
    
    [tabs addObject:basketBallTab];
    [tabs addObject:meTab];
    
    [self setViewControllers:tabs animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
