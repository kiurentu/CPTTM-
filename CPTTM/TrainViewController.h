//
//  ClassViewController.h
//  CPTTM
//
//  Created by Admin on 28/5/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "ViewController.h"




@interface TrainViewController : ViewController<UITableViewDelegate, UITableViewDataSource>  

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


/**
 *  setView ishidden Button
 *
 *  @param sender nil
 */
- (IBAction)setBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *setView;



/**
 *  setView Button *4
 */
@property (weak, nonatomic) IBOutlet UIButton *tailoringButton;

@property (weak, nonatomic) IBOutlet UIButton *newsButton;

@property (weak, nonatomic) IBOutlet UIButton *languageButton;

@property (weak, nonatomic) IBOutlet UIButton *manageButton;

@end
