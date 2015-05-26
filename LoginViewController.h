//
//  LoginViewController.h
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseApi.h"
#import "LoginApi.h"
#import "UserModel.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (strong , nonatomic) LoginApi *apiLogin;

@property (weak, nonatomic) IBOutlet UIImageView *authcodeImageView;

- (IBAction)loginSubmit:(id)sender;

@end
