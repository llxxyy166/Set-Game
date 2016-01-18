//
//  Deck.h
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;

@end
