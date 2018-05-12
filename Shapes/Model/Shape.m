//
//  Shape.m
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import "Shape.h"
static int identifier = 0;

@implementation Shape
{
    int shapeType;
    int uid;
    CGPoint originCenter;
    UIColor *shapeColor;
}


- (instancetype)initWithtype:(int)type width:(float)width height:(float)height
{
    self = [super init];
    if (self) {
        shapeType = type;
        uid = identifier;
        identifier++;
        originCenter = [self randomPoint:width height:height];
        shapeColor = [self randomColor];
    }
    return self;
}

-(CGPoint)getOrigin{
    return originCenter;
}

-(UIColor*)getshapeColor{
    return shapeColor;
}

-(int)getUid{
    return uid;
}

-(int)getType{
    return shapeType;
}


-(UIColor*)randomColor{
    CGFloat hue = arc4random() % 255 / 255.0;
    return [UIColor colorWithHue:hue saturation:0.8 brightness:1.0 alpha:0.8];
}

-(CGPoint)randomPoint:(float)width height:(float)height{
    int rX = arc4random_uniform(width-100) + 100;
    int rY  = arc4random_uniform(height-300) + 200;
    return CGPointMake(rX,rY);
}

-(NSString *)description{
    NSString *descriptionString = [NSString stringWithFormat:@"type:%d \n id:%d \n",uid,shapeType];
    return descriptionString;
}

@end
