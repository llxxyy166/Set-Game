//
//  SetCardView.h
//  CardGame
//
//  Created by xinye lei on 15/12/17.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;
@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL marked;
@property (nonatomic) CGRect originPosition;
@end
