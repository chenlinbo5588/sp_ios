//
//  RegisterPhoneViewController.h
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterApi.h"

@interface RegisterPhoneViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (nonatomic, strong) RegisterApi *registerApi;


- (IBAction)nextButtonSubmit:(id)sender;

@end
