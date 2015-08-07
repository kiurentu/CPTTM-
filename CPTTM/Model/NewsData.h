//
//  NewsData.h
//  CPTTM
//
//  Created by LiuWenYu on 15/6/29.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"
@interface NewsData : NSObject

@property (copy,nonatomic) NSString *ID;

@property (copy,nonatomic) NSDate *createdTime;

@property(strong,nonatomic) News * news;


@end
