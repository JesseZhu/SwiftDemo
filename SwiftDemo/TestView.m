//
//  TestView.m
//  SwiftDemo
//
//  Created by Jesse on 2019/11/27.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

#import "TestView.h"

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints = false;
//        NSLayoutConstraint *constraint = [NSLayoutConstraint  constraintWithItem:<#(nonnull id)#> attribute:<#(NSLayoutAttribute)#> relatedBy:<#(NSLayoutRelation)#> toItem:<#(nullable id)#> attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>]
//:       [NSLayoutConstraint activateConstraints:@[ ]];
        NSLog(@"Print new home thanks for you help ok good moring vehcile");
    }
    return self;
}



@end
