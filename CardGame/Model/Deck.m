//
//  Deck.m
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end
@implementation Deck

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card {
    [self.cards addObject:card];
}

- (Card *)drawRandomCard {
    Card *card = nil;
    if ([self.cards count]) {
        NSUInteger index = arc4random() % [self.cards count];
        card = [self.cards objectAtIndex:index];
        [self.cards removeObjectAtIndex:index];
    }
    return card;
}

@end
