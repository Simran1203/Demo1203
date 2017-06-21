//
//  GradiantBackgroundView.m
//  AikoAndEgor
//
//  Created by Syed Faran Ghani on 08/02/16.
//  Copyright © 2016 Agicent. All rights reserved.
//

#import "GradiantBackgroundView.h"

@implementation GradiantBackgroundView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    /* Method To set gradiant color to uiview  */
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    UIColor *topColor = [UIColor colorWithRed:2.0/255.0 green:102.0/255.0 blue:98.0/255.0 alpha:1.0];
    UIColor *buttomColor = [UIColor colorWithRed:1.0/255.0 green:29.0/255.0 blue:28.0/255.0 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[buttomColor CGColor], nil];
    [self.layer insertSublayer:gradient atIndex:0];

}


@end
