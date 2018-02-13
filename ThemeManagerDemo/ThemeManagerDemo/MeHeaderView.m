//
//  MeHeaderView.m
//  testHome
//
//  Created by smok on 2017/5/3.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "MeHeaderView.h"
#import "ThemeManager.h"

@interface MeHeaderView()
@property (weak, nonatomic) IBOutlet UILabel  *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *desButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MeHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.desLabel th_setTextColor];
    [self.desButton th_setBackgroundColor];
    [self.imageView th_setBackgroundColor];
}

@end
