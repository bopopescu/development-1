//
//  DieView.m
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import "DieView.h"

@implementation DieView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initializing the die image

        self.backgroundColor = [UIColor clearColor];
        
        self.dieImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        // Adding it to this view
        [self addSubview:self.dieImage];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showDieNumber:(int)num
{
    // Constructing the filename based on the die number
    NSString *fileName = [NSString stringWithFormat:@"dice%d.png", num];
    // Setting the uiimageview to the appropriate image
    self.dieImage.image = [UIImage imageNamed:fileName];
}

@end
