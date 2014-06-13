// ========================================================================================
// Source: http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
// ========================================================================================

//
//  UIImageResizing.h
//  iBeaconTableViewStory
//
//  Created by Brian Sterner on 6/10/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

// Put this in UIImageResizing.h
@interface UIImage (Resize)
- (UIImage*)scaleToSize:(CGSize)size;
@end
