//
//  RegisterPhoneAuthViewController.h
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterApi.h"


@interface RegisterPhoneAuthViewController : UIViewController

@property (nonatomic, strong) RegisterApi *registerApi;

@property (nonatomic,strong) NSString *phoneNo;
@property (weak, nonatomic) IBOutlet UITextField *authCodeText;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@property (weak, nonatomic) IBOutlet UIButton *phoneAuthNextBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resendBarItem;

- (IBAction)phoneAuthNextSubmit:(id)sender;
- (IBAction)resendAuthCode:(id)sender;

@end
