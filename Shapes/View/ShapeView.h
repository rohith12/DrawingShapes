//
//  ShapeView.h
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"
#import "Constants.h"

@protocol ShapeViewDelegate<NSObject>

-(void)deleteFromView:(int)uid;

@end

@interface ShapeView : UIView

@property(nonatomic,weak)id<ShapeViewDelegate>deleagte;
-(id)initWithModel:(Shape*)shapeModel;
@end
