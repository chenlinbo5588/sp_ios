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
    
    //NSDictionary *param = [[NSDictionary alloc] initWithObjects:@[_upid] forKeys:@[@"upid"]];
    
    
    NSString *query = [NSString stringWithFormat:@"/index.php/district/index/upid/%@",_upid];
    MKNetworkOperation *op = [self operationWithPath:query
                                              params:nil
                                          httpMethod:@"GET"];
    
    
    NSLog(@"OP=%@",op.url);
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         DLog(@"Data from %@", [completedOperation.readonlyResponse allHeaderFields]);
         
         NSError *respErrror ;
         NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:completedOperation.responseData options:NSJSONReadingMutableLeaves error:&respErrror];
         
         completionBlock(json);
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
    
}

@end
