//
//  DistrictApi.m
//  sp
//
//  Created by Apple on 15-5-19.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "DistrictApi.h"

@implementation DistrictApi


-(MKNetworkOperation *)getDistrictByPid:(JSONResponseBlock)completionBlock
                 errorHandler:(MKNKErrorBlock)errorBlock
{
    
    if(_upid == nil){
        _upid = [NSMutableString stringWithFormat:@"0"];
    }
    
    NSString *url = [NSString stringWithFormat:@"/index.php/district/index/upid/%@",_upid];
    
    return [self apiRequest:url postdata:nil completionHandler:^(NSJSONSerialization *json) {
        completionBlock(json);
    } errorHandler:^(NSError *error) {
        errorBlock(error);
    }];
    
}

@end
