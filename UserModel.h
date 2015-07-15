//
//  UserModel.h
//  sp
//
//  Created by Apple on 15-5-11.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic , strong) NSString *uid;
@property (nonatomic , strong) NSString *username;


@end
