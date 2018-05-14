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
    undoManager = [[NSUndoManager alloc] init];
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

- (IBAction)undo:(id)sender {
    
    [undoManager undo];
    
}



- (IBAction)stats:(id)sender {
    
    [self performSegueWithIdentifier:@"stats" sender:sender];
    
}





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
    }
}

-(void)didPan:(UIPanGestureRecognizer*)recognizer{
    ShapeView* shapeView = (ShapeView*)recognizer.view;
    CGPoint sumPoint;

    if ([recognizer state] == UIGestureRecognizerStateBegan){
        [self shapeMoved:shapeView center:shapeView.center];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self.view];
        sumPoint=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
        shapeView.center = sumPoint;
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    
}

#pragma mark - Helpers

-(void)addFigure:(int)senderTag model:(Shape*)model{
    
    [self.shapes addObjectToArray:model];
    shapeView = [[ShapeView alloc]initWithModel:model];
    shapeView.deleagte = self;
    
    [[undoManager prepareWithInvocationTarget:self]remvoeFromArray:shapeView];
    [undoManager setActionName:NSLocalizedString(@"actions.add", @"Add Shape")];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [shapeView addGestureRecognizer:pan];
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteObject:)];
    [shapeView addGestureRecognizer:longPress];
    [self.view addSubview:shapeView];

}


-(void)shapeMoved:(ShapeView*)shape center:(CGPoint)origin{
    
    [[undoManager prepareWithInvocationTarget:self]shapeMoved:shapeView center:origin];
    [undoManager setActionName:NSLocalizedString(@"actions.moved", @"Move Shape")];
    
    shape.center = origin;
}


-(void)remvoeFromArray:(ShapeView*)shape{
    
    [[undoManager prepareWithInvocationTarget:self]addFigure:shape.getType model:[shape getModel]];
    [undoManager setActionName:NSLocalizedString(@"actions.remove", @"Remove Shape")];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [shape removeFromSuperview];
        [shape setNeedsDisplay];
    });
    
    [self.shapes removeShapeById:shape.getUniqueId];
    
}



@end
