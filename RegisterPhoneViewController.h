//
//  RegisterPhoneViewController.h
//  sp
//
//  Created by Apple on 15-5-26.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPhoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
- (IBAction)nextButtonSubmit:(id)sender;

@end
