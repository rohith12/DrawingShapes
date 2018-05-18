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
//    self.shapes = [[ShapeObjects alloc] init];
    undoManager = [[NSUndoManager alloc] init];
    self.AllShapes = [[NSMutableArray alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions

- (IBAction)drawShapes:(UIButton*)sender {
    type = (int)sender.tag;
    model  = [[Shape alloc]initWithtype:type width:self.view.frame.size.width  height:self.view.frame.size.height];
    shapeView = [[ShapeView alloc]initWithModel:model];
    [self addFigure:type model:model shapeView:shapeView];
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
    [dvc receiveDictionary:[self getShapesCountByType]];
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

-(void)addFigure:(int)senderTag model:(Shape*)model  shapeView:(ShapeView*)shapeView{
    
    [[undoManager prepareWithInvocationTarget:self]remvoeFromArray:shapeView];
    if (![undoManager isUndoing]) {
        
        [undoManager setActionName:NSLocalizedString(@"actions.add", @"Add Shape")];
    }
    
    [self.AllShapes addObject:model];

    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [shapeView addGestureRecognizer:pan];
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteObject:)];
    [shapeView addGestureRecognizer:longPress];
    [self.view addSubview:shapeView];

   
}


-(void)shapeMoved:(ShapeView*)shape center:(CGPoint)origin{
   
    shape.center = origin;

    [[undoManager prepareWithInvocationTarget:self]shapeMoved:shapeView center:origin];
    if(![undoManager isUndoing]) {
       [undoManager setActionName:NSLocalizedString(@"actions.moved", @"Move Shape")];
    }
}


-(void)remvoeFromArray:(ShapeView*)shape{
    
    [[undoManager prepareWithInvocationTarget:self]addFigure:shape.getType model:[shape getModel] shapeView:shape];
    if (![undoManager isUndoing]) {
       [undoManager setActionName:NSLocalizedString(@"actions.remove", @"Remove Shape")];
    }
    
        [shape removeFromSuperview];
        [shape setNeedsDisplay];
    
    [self removeShapeById:shape.getUniqueId];
    
   
    
}

-(void)removeShapeById:(int)uid{
    
    for(Shape* shape in [self.AllShapes reverseObjectEnumerator]){
        if([shape getUid] == uid){
            [self.AllShapes removeObject:shape];
        }
    }
    
}

-(NSDictionary*)getShapesCountByType{
    
    int squares = 0;
    int circles = 0;
    int triangles = 0;
    for(Shape* shape in self.AllShapes){
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


@end
