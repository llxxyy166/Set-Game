//
//  Card.h
//  CardGame
//
//  Created by xinye lei on 15/12/15.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL avaliable;
- (int)match:(NSArray *) otherCards;

@end
