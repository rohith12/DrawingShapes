//
//  Shape.h
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Shape : NSObject

- (instancetype)initWithtype:(int)type width:(float)width height:(float)height;
-(int)getUid;
-(UIColor*)getshapeColor;
-(CGPoint)getOrigin;
-(int)getType;
@end
