//
//  SetCardView.m
//  CardGame
//
//  Created by xinye lei on 15/12/17.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView ()
@property (strong, nonatomic)UIBezierPath *path;
@end

@implementation SetCardView

- (void)setMarked:(BOOL)marked {
    _marked = marked;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol {
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number {
    _number = number;
    [self setNeedsDisplay];
}

- (void)setChosen:(BOOL)chosen {
    _chosen = chosen;
    [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180
#define CORNER_RADIUS 12

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat)cornerOffset {
    return [self cornerRadius] / 3.0;
}

- (void)mark:(NSUInteger)index {
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    if (!self.chosen) {
        [[UIColor whiteColor] setFill];
    }
    else {
        [[UIColor grayColor] setFill];
    }
    if (self.marked) {
        [[UIColor blackColor] setFill];
    }
    [roundedRect fill];
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    self.path = roundedRect;
    
}

- (void)setUp {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;

    
}

- (void)awakeFromNib {
    [self setUp];
}





@end
