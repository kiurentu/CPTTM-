//
//  FaceBookService.h
//  CPTTM
//
//  Created by LiuWenYu on 15/6/10.
//  Copyright © 2015年 biz.ourmi. All rights reserved.
//

#import "BaseService.h"
extern NSString *BizCloudNotification_Network_Reachable;

@interface FaceBookService : BaseService

singleton_interface(FaceBookService)

-(RACSignal *)feedOfPage:(NSString *)pageId withFields:(NSArray *)fields;

-(RACSignal *)feedOfPage:(NSString *)pageId withFields:(NSArray *)fields until:(long) until;


@end
