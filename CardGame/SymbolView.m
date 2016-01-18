//
//  SymbolView.m
//  CardGame
//
//  Created by xinye lei on 15/12/17.
//  Copyright © 2015年 xinye lei. All rights reserved.
//

#import "SymbolView.h"


@implementation SymbolView

- (void)setUp {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setUp];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    UIBezierPath *path;
    if ([self.symbol isEqualToString:@"circle"]) {
        path = [self drawCircle];
    }
    if ([self.symbol isEqualToString:@"square"]) {
        path = [self drawSquare];
    }
    if ([self.symbol isEqualToString:@"triangle"]) {
        path = [self drawTriangle];
    }
    
    if ([self.color isEqualToString:@"red"]) {
        [[UIColor redColor] setFill];
        [[UIColor redColor] setStroke];
    }
    if ([self.color isEqualToString:@"green"]) {
        [[UIColor greenColor] setFill];
        [[UIColor greenColor] setStroke];
    }
    if ([self.color isEqualToString:@"purple"]) {
        [[UIColor purpleColor] setFill];
        [[UIColor purpleColor] setStroke];
    }
    
    if ([self.shading isEqualToString:@"open"]) {
        [[UIColor clearColor] setFill];
    }
    if ([self.shading isEqualToString:@"striped"]) {
        [path addClip];
        [[UIColor clearColor] setFill];
        CGPoint v1, v2;
        for (v1.x = self.bounds.origin.x, v1.y = self.bounds.origin.y, v2.x = self.bounds.origin.x + self.bounds.size.width, v2.y = self.bounds.origin.y; v1.y < self.bounds.origin.y + self.bounds.size.height; v1.y += self.bounds.size.height / 8.0, v2.y += self.bounds.size.height / 8.0) {
            [path moveToPoint:v1];
            [path addLineToPoint:v2];
        }
    }
    [path stroke];
    [path fill];

    
}

- (UIBezierPath *)drawCircle{   //oval
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGRect bounds = self.bounds;
    CGFloat radius = 0.9 * bounds.size.height / 2.0;
    CGPoint c1, c2;
    c1.x = bounds.origin.x + radius;
    c1.y = bounds.origin.y + radius;
    c2.x = bounds.origin.x + bounds.size.width -radius;
    c2.y = bounds.origin.y + radius;
    [path moveToPoint:CGPointMake(c1.x, bounds.origin.y)];
    [path addArcWithCenter:c1 radius:radius startAngle: -M_PI / 2.0 endAngle: M_PI / 2.0 clockwise:NO];
    [path addLineToPoint:CGPointMake(c2.x, path.currentPoint.y)];
    [path addArcWithCenter:c2 radius:radius startAngle:M_PI / 2.0 endAngle:-M_PI / 2.0 clockwise:NO];
    [path closePath];
    return path;
    
}

- (UIBezierPath *)drawTriangle {  //diamond
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGRect bounds = self.bounds;
    CGPoint v1, v2, v3, v4;
    v2.x = bounds.origin.x + 0.05 * bounds.size.width;
    v2.y = bounds.origin.y + bounds.size.height / 2.0;
    v3.x = bounds.origin.x + bounds.size.width - 0.05 * bounds.size.width;
    v3.y = bounds.origin.y + bounds.size.height / 2.0;
    v1.x = bounds.origin.x + bounds.size.width / 2.0;
    v1.y = bounds.origin.y + 0.05 * bounds.size.height;
    v4.x = bounds.origin.x + bounds.size.width / 2.0;
    v4.y = bounds.origin.y + bounds.size.height - 0.05 * bounds.size.height;
    [path moveToPoint:v1];
    [path addLineToPoint:v2];
    [path addLineToPoint:v4];
    [path addLineToPoint:v3];
    [path closePath];
    return path;
}

- (UIBezierPath *)drawSquare { //squiggle
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGRect bounds = self.bounds;
    [path moveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.05, bounds.origin.y + bounds.size.height*0.40)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.35, bounds.origin.y + bounds.size.height*0.25)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.09, bounds.origin.y + bounds.size.height*0.15)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.18, bounds.origin.y + bounds.size.height*0.10)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.75, bounds.origin.y + bounds.size.height*0.30)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.40, bounds.origin.y + bounds.size.height*0.30)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.60, bounds.origin.y + bounds.size.height*0.45)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.97, bounds.origin.y + bounds.size.height*0.35)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.87, bounds.origin.y + bounds.size.height*0.15)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.98, bounds.origin.y + bounds.size.height*0.00)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.45, bounds.origin.y + bounds.size.height*0.85)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.95, bounds.origin.y + bounds.size.height*1.10)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.50, bounds.origin.y + bounds.size.height*0.95)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.25, bounds.origin.y + bounds.size.height*0.85)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.40, bounds.origin.y + bounds.size.height*0.80)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.35, bounds.origin.y + bounds.size.height*0.75)];
    
    [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.05, bounds.origin.y + bounds.size.height*0.40)
            controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.00, bounds.origin.y + bounds.size.height*1.10)
            controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.005, bounds.origin.y + bounds.size.height*0.60)];
    
    [path closePath];
    return path;
}


@end
