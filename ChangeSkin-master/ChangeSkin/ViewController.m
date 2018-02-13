//
//  ViewController.m
//  ChangeSkin
//
//  Created by Agenric on 2016/12/12.
//  Copyright © 2016年 Agenric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageView1 setImage:[UIImage imageNamed:@"image1"]];
    [self.imageView2 setImage:[UIImage imageNamed:@"image2"]];
    [self.imageView3 setImage:[UIImage imageNamed:@"image3"]];
    [self.imageView4 setImage:[UIImage imageNamed:@"image4"]];
    
}

@end
