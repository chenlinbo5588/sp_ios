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


-(id) initWithDefaultSettings ;
-(id) initWithHostName:(NSString *)hostName;
-(id) initWithHostName:(NSString *)hostName customHeaderFields:(NSDictionary *)headers;


@end


