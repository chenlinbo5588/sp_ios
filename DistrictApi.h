//
//  DistrictApi.h
//  sp
//
//  Created by Apple on 15-5-19.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BaseApi.h"

@interface DistrictApi : BaseApi



@property (strong,nonatomic) NSMutableString *upid;
@property NSInteger component;


-(MKNetworkOperation *)getDistrictByPid:(JSONResponseBlock)completionBlock
                           errorHandler:(MKNKErrorBlock)errorBlock;

@end
