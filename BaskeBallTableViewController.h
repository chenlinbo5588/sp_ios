//
//  BaskeBallTableViewController.h
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasketTeamTableViewController.h"

#import "DistrictApi.h"

#define BASKET_TEAM_ROWINDEX 0
#define BASKET_SITE_ROWINDEX 1
#define BASKET_RULE_ROWINDEX 2
#define BASKET_TOOL_ROWINDEX 3
#define BASKET_TACTICS_ROWINDEX 4


#define BASKET_JUDGE_ROWINDEX 0
#define BASKET_LEAGUE_ROWINDEX 1

@interface BaskeBallTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>


@property (strong,nonatomic) DistrictApi *districtApi;


@property (strong ,nonatomic) UITapGestureRecognizer *tagRecoginer;
@property (strong ,nonatomic) MKNetworkOperation *districtOperation;
@property (strong, nonatomic) UIPickerView *distrctPickerView;
@property (strong ,nonatomic) NSMutableDictionary *districtDict;


@end
