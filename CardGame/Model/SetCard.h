//
//  SetCard.h
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColor;
+ (NSArray *)validShading;
+ (NSArray *)validSymbol;
+ (NSArray *)validNumber;

@end
