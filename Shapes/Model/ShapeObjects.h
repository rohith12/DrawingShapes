//
//  ShapeObjects.h
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
#import "Constants.h"

@interface ShapeObjects : NSObject
-(Shape*)addObject:(int)tag width:(float)width height:(float)height;
-(void)removeShapeById:(int)uid;
-(NSDictionary*)getShapesCountByType;
-(void)addObjectToArray:(Shape*)shapeModel;
@end
