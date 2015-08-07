//
//  News.m
//  CPTTM
//
//  Created by Admin on 11/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "News.h"
#import <MJExtension.h>
@implementation News

/**
 *  model News mapping with MJExtension
 *
 *  @return FaceBook the property 
 */
+(NSDictionary *)replacedKeyFromPropertyName
{
    //id,message,picture
             return @{
                    @"newsMessage":@"message",
                    @"newsPicture":@"full_picture"
                      };
             
    
}
@end

