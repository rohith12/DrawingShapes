//  ShapeView.m
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import "ShapeView.h"

const float size = 200.0;
const float pathSize = 100.0;
const float lineWidth = 1.0;

@implementation ShapeView{
    UIBezierPath* path;
    UIColor* fillColor;
    int uniqueId;
    int type;
    Shape* model;
}

-(id)initWithModel:(Shape *)shapeModel{
    
    if((self = [super initWithFrame:CGRectMake(0.0,0.0, size, size)])) {
        model = shapeModel;
        type = [model getType];
        path = [self linePathtype:type];
        path.lineWidth = lineWidth;
        self.center = [model getOrigin];
        fillColor = [model getshapeColor];
        uniqueId = [model getUid];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [fillColor setFill];
    [fillColor setStroke];
    [path fill];
    [path stroke];
    
}

#pragma mark helpers

-(UIBezierPath*)linePathtype:(int)shape{
    
    UIBezierPath* linePath;
    
    CGRect rect = CGRectMake(0.0,0.0 , pathSize, pathSize);
    
    switch (shape) {
        case ShapeTypeSquare:
            linePath = [UIBezierPath bezierPathWithRect:rect];
            break;
        case ShapeTypeCircle:
            linePath = [UIBezierPath bezierPathWithOvalInRect:rect];
            break;
        case ShapeTypeTriangle:
            linePath = [UIBezierPath bezierPath];
            [linePath moveToPoint:CGPointMake(rect.size.width / 2.0, rect.origin.y)];
            [linePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
            [linePath addLineToPoint:CGPointMake(rect.origin.x,rect.size.height)];
            [linePath closePath];
            break;
        default:
            break;
    }
    
    return linePath;
    
}

-(int)getUniqueId{
    return uniqueId;
}


-(int)getType{
    return type;
}

-(Shape*)getModel{
    return model;
}

@end
