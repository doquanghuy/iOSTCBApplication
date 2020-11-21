//
//  BBBackgroundImageHandler.h
//  Rorschach
//
//  Created by Backbase B.V. on 29/03/2019.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBBACKGROUNDIMAGEHANDLER_CLASS
#define BBBACKGROUNDIMAGEHANDLER_CLASS

@interface BBBackgroundImageHandler : BBBackgroundImageParser
@end

/// Provides Base funcitionality to apply background color in case of gradient otherwise it calls
/// setBackGroundImage:(UIImage*)image forView:(UIView*)view
@interface BBBaseBackgroundHandler : BBBackgroundImageHandler <DeclarationHandler>
- (BOOL)setBackGroundImage:(UIImage*)image forView:(UIView*)view;
@end

/// Provides functionality to apply a background gradient to a UIView.
@interface BBUIViewBackgroundGradientHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background gradient to a UIImageView.
@interface BBUIImageViewBackgroundGradientHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UIButton.
@interface BBUIButtonBackgroundImageHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UIToolbar.
@interface BBUIToolbarBackgroundImageHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UITabBar.
@interface BBUITabBarBackgroundImageHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UISearchBar.
@interface BBUISearchBarBackgroundImageHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UINavigationBar.
@interface BBUINavigationBarBackgroundImageHandler : BBBaseBackgroundHandler
@end

/// Provides functionality to apply a background image to a UISegmentedControl.
@interface BBUISegmentedControlBackgroundImageHandler : BBBaseBackgroundHandler
@end

#endif
