//
//  BaseApi.h
//  sp
//
//  Created by Apple on 15-5-14.
//  Copyright (c) 2015年 clb. All rights reserved.
//

#import "MKNetworkEngine.h"


@interface BaseApi : MKNetworkEngine

typedef void (^JSONResponseBlock)(NSJSONSerialization *json);

@property (strong,nonatomic) NSString *formhash;
@property (strong,nonatomic) NSString *verify;



-(id) initWithDefaultSettings ;
-(id) initWithHostName:(NSString *)hostName;
-(id) initWithHostName:(NSString *)hostName customHeaderFields:(NSDictionary *)headers;


-(MKNetworkOperation *)formhash:(JSONResponseBlock)completionBlock
                   errorHandler:(MKNKErrorBlock) errorBlock;


-(MKNetworkOperation *)apiRequest:(NSString *)url postdata:(NSDictionary *)params
                completionHandler:(JSONResponseBlock) completionBlock
                     errorHandler:(MKNKErrorBlock) errorBlock;

@end


