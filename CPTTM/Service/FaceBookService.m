//
//  FaceBookService.m
//  CPTTM
//
//  Created by LiuWenYu on 15/6/10.
//  Copyright © 2015年 biz.ourmi. All rights reserved.
//

#import "FaceBookService.h"

@implementation FaceBookService


singleton_implementation(FaceBookService)

-(instancetype)init
{
    self=[super init];
    if (self) {
        self.httpManager=[BaseService setUpHttpManageWihth:@"https://graph.facebook.com/v2.3/"];
    }
    return self;
}
-(RACSignal *)feedOfPage:(NSString *)pageId withFields:(NSArray *)fields
{
    return [self feedOfPage:pageId withFields:fields until: 0];
}


-(RACSignal *)feedOfPage:(NSString *)pageId withFields:(NSArray *)fields until:(long) until
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:
  @{
    @"fields":@"id,message,full_picture",
    @"access_token":@"1646214315608108|qoYlgpM3diNfv6l_JcutWl3S74o"
    }];
    if (until) {
        params[@"until"] = @(until);
    }
    
    return [super getUrl:[NSString stringWithFormat:@"%@/feed",pageId]
              withParams:params
            ];
}
@end
