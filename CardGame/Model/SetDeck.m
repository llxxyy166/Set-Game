//
//  SetDeck.m
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"
@implementation SetDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (int number = 1; number <= 3 ; number++) {
            for (NSString *color in [SetCard validColor]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (NSString *symbol in [SetCard validSymbol]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shading =shading;
                        card.symbol = symbol;
                        card.number = (NSUInteger)number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
