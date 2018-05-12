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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shapes = [[ShapeObjects alloc] init];
   // undoManager = [[NSUndoManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)drawShapes:(UIButton*)sender {
    ShapeView* shapeView = [[ShapeView alloc]initWithModel:[self.shapes addObject:(int)sender.tag width:self.view.frame.size.width height:self.view.frame.size.height]];
    shapeView.deleagte = self;
    [self.view addSubview:shapeView];
}


- (IBAction)undo:(id)sender {
    //[undoManager undo];
}



- (IBAction)stats:(id)sender {
    
    [self performSegueWithIdentifier:@"stats" sender:sender];
    
}

#pragma mark delegates

-(void)deleteFromView:(int)uid{
    [self.shapes removeShapeById:uid];
}

#pragma mark segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    StatTableViewController* dvc = [segue destinationViewController];
    [dvc receiveDictionary:[self.shapes getShapesCountByType]];
}




@end
