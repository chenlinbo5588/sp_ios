//
//  BaseModel.h
//  sp
//
//  Created by Apple on 15-6-4.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "JSONModel.h"

@interface BaseModel : JSONModel

@property (nonatomic,strong) NSString<Optional> *code;
@property (nonatomic,strong) NSString<Optional> *message;
@property (nonatomic,strong) NSString<Optional> *formhash;
@property (nonatomic,strong) NSString<Optional> *verify;

@end
