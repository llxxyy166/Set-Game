//
//  SetCard.m
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validColor {
    return @[@"red",@"green",@"purple"];
}

+ (NSArray *)validShading {
    return @[@"solid",@"striped",@"open"];
}

+ (NSArray *)validSymbol {
    return @[@"square",@"triangle",@"circle"];
}

+ (NSArray *)validNumber {
    return @[@1,@2,@3];
}


- (int)match: (NSArray *)otherCards {
    SetCard *card0 = [otherCards objectAtIndex:0];
    SetCard *card1 = [otherCards objectAtIndex:1];
    
    if (card0.color == card1.color && card0.color != self.color) {
        return 0;
    }
    if (card0.color == self.color && card0.color != card1.color) {
        return 0;
    }
    if (card1.color == self.color && card0.color != self.color) {
        return 0;
    }
    
    if (card0.shading == card1.shading && card0.shading != self.shading) {
        return 0;
    }
    if (card0.shading == self.shading && card0.shading != card1.shading) {
        return 0;
    }
    if (card1.shading == self.shading && card0.shading != self.shading) {
        return 0;
    }
    
    if (card0.symbol == card1.symbol && card0.symbol != self.symbol) {
        return 0;
    }
    if (card0.symbol == self.symbol && card0.symbol != card1.symbol) {
        return 0;
    }
    if (card1.symbol == self.symbol && card0.symbol != self.symbol) {
        return 0;
    }
    
    if (card0.number == card1.number && card0.number != self.number) {
        return 0;
    }
    if (card0.number == self.number && card0.number != card1.number) {
        return 0;
    }
    if (card1.number == self.number && card0.number != self.number) {
        return 0;
    }
    return 1;
}


@end
