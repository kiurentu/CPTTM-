//
//  BaseService.m
//  CPTTM
//
//  Created by Admin on 10/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "BaseService.h"

NSString* BizCloudNotification_Network_Reachable = @"biz.ourmi.bizcloud.network.reachable";
//@interface BaseService ()
//
//
//@end

@implementation BaseService

-(RACSignal *) getUrl: (NSString *) url withParams:(NSDictionary *)queries
{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *o =
        [self.httpManager GET: url
                    parameters: queries
                       success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
                           [subscriber sendNext:responseObject];
                           [subscriber sendCompleted];
         }
                       failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
                           [subscriber sendError: error];
                           
          }];
        
        return [RACDisposable disposableWithBlock:^{
            [o cancel];
        }];
    }];
    
}
+(AFHTTPRequestOperationManager *) setUpHttpManageWihth: (NSString *)baseURLString
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: baseURL];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSOperationQueue *operationQueue =  manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //                NSLog(@"suspended: no");
                [operationQueue setSuspended:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:BizCloudNotification_Network_Reachable object:@(YES)];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                //                NSLog(@"suspended: yes");
                [operationQueue setSuspended:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:BizCloudNotification_Network_Reachable object:@(NO)];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    
    return manager;
}

@end
