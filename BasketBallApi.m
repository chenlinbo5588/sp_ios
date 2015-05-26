//
//  BasketBallApi.m
//  sp
//
//  Created by Apple on 15-5-19.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "BasketBallApi.h"

@implementation BasketBallApi


/**
 * 获得统计数据
 *
 */

-(MKNetworkOperation *)getMainListStat:(NSString *)balltype
                     completionHandler:(JSONResponseBlock)completionBlock
                          errorHandler:(MKNKErrorBlock)errorBlock
{
    
    
    //NSString *queryStr = [NSString stringWithFormat:@"/index.php?c=basketball&m=mainstat&random=%@"];
    
    
    MKNetworkOperation *op = [self operationWithPath:@"/index.php/basketball/mainstat"
                                              params:nil
                                          httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         // the completionBlock will be called twice.
         // if you are interested only in new values, move that code within the else block
         
         /*
          NSString *valueString = [[completedOperation responseString] componentsSeparatedByString:@","][1];
          DLog(@"%@", valueString);
          */
         if([completedOperation isCachedResponse]) {
             DLog(@"Data from cache %@", [completedOperation responseString]);
         }
         else {
             DLog(@"Data from server %@", [completedOperation responseString]);
         }
         
         
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
