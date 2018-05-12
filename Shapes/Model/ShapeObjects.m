//
//  ShapeObjects.m
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import "ShapeObjects.h"
@implementation ShapeObjects
{
  NSMutableArray* shapeObjects;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        shapeObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

-(Shape*)addObject:(int)tag width:(float)width height:(float)height{
    Shape* shapeModel = [[Shape alloc]initWithtype:tag width:width height:height];
    return shapeModel;
}

-(void)removeShapeById:(int)uid{
    
    for(Shape* shape in [shapeObjects reverseObjectEnumerator]){
        if([shape getUid] == uid){
            [shapeObjects removeObject:shape];
        }
    }
    
}

-(NSDictionary*)getShapesCountByType{
    
    int squares = 0;
    int circles = 0;
    int triangles = 0;
    for(Shape* shape in shapeObjects){
        switch (shape.getType) {
            case ShapeTypeSquare:
                squares++;
                break;
            case ShapeTypeCircle:
                circles++;
                break;
            case ShapeTypeTriangle:
                triangles++;
                break;
            default:
                break;
        }
    }
    
    NSDictionary* dict = @{@"Square":[NSNumber numberWithInt:squares],@"Circles":[NSNumber numberWithInt:circles],@"Triangles":[NSNumber numberWithInt:triangles]};
    return dict;
}


-(void)addObjectToArray:(Shape*)shapeModel{
    [shapeObjects addObject:shapeModel];

}

//-(void)addShapeById:(int)uid{
//    for(Shape* shape in [shapeObjects reverseObjectEnumerator]){
//        if([shape getUid] == uid){
//            [shapeObjects removeObject:shape];
//        }
//    }
//}


@end
