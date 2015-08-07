//
//  dismissKeyboard.m
//  CPTTM
//
//  Created by Admin on 1/6/15.
//  Copyright (c) 2015年 biz.ourmi. All rights reserved.
//

#import "TrainView.h"

@implementation TrainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/**
*  pack up keyboard
*
*  @param point touch screen
*  @param event touch screen to pack up keyboard
*
*  @return view
*/
- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    [self endEditing:YES];
    return hitView;
}

@end
