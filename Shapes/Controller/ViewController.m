//
//  ViewController.m
//  Shapes
//
//  Created by Rohith Raju on 11/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController
{
    ShapeView* shapeView;
    Shape* model;
    int type;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.shapes = [[ShapeObjects alloc] init];
//    undoManager = [[NSUndoManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions

- (IBAction)drawShapes:(UIButton*)sender {
    type = (int)sender.tag;
    model = [self.shapes addObject:type width:self.view.frame.size.width height:self.view.frame.size.height];
    [self addFigure:type model:model];
}




- (IBAction)stats:(id)sender {
    
    [self performSegueWithIdentifier:@"stats" sender:sender];
    
}

#pragma mark delegates


//-(void)deleteFromView:(int)uid{
//    [self.shapes removeShapeById:uid];
//}

#pragma mark segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    StatTableViewController* dvc = [segue destinationViewController];
    [dvc receiveDictionary:[self.shapes getShapesCountByType]];
}

#pragma mark - Gesture recognisers
-(void)deleteObject:(UILongPressGestureRecognizer*)sender{
    ShapeView* shape = (ShapeView*) sender.view;
    if (shape != nil){
        if (sender.state == UIGestureRecognizerStateEnded) {
           [self remvoeFromArray:shape];
        }
        else if (sender.state == UIGestureRecognizerStateBegan){
        }
    }
}

-(void)didPan:(UIPanGestureRecognizer*)recognizer{
    ShapeView* shapeView = (ShapeView*)recognizer.view;
    if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint sumPoint=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
        shapeView.center = sumPoint;
       // [self registerUndoMoveFigure:sumPoint shape:(Shapes*)recognizer.view];
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    
}

#pragma mark - Helpers

-(void)addFigure:(int)senderTag model:(Shape*)model{
    
 
    
    [self.shapes addObjectToArray:model];
    shapeView = [[ShapeView alloc]initWithModel:model];
    
    shapeView.deleagte = self;
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [shapeView addGestureRecognizer:pan];
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteObject:)];
    [shapeView addGestureRecognizer:longPress];
    [self.view addSubview:shapeView];
}

-(void)remvoeFromArray:(ShapeView*)shape{
    
 
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [shape removeFromSuperview];
        [shape setNeedsDisplay];
    });
    [self.shapes removeShapeById:shape.getUniqueId];
    
}



@end
