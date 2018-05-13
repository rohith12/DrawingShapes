//
//  ViewController.h
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ShapeView.h"
#import "ShapeObjects.h"
#import "StatTableViewController.h"
@interface ViewController : UIViewController<ShapeViewDelegate>
{
   // NSUndoManager* undoManager;
}
@property(nonatomic,strong)ShapeObjects* shapes;

@end

