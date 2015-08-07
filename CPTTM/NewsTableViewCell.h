//
//  NewsTableViewCell.h
//  CPTTM
//
//  Created by Admin on 24/6/2015.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell


/**
 *  NewsTable cell property
 */
@property (weak, nonatomic) IBOutlet UIImageView *newsPicture;
@property (weak, nonatomic) IBOutlet UITextView *newsMessage;
@end
