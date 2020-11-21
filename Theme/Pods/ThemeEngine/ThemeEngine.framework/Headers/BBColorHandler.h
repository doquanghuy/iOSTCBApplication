//
//  BBColorHandler.h
//  Rorschach
//
//  Created by Backbase B.V. on 05/09/2019.
//  Copyright © 2019 Backbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBCOLORHANDLER_CLASS
#define BBCOLORHANDLER_CLASS

/// Provides functionality to apply an [A]RGB color to a unspecialized view element, given that it supports text color.
@interface BBColorHandler : BBColorParser <DeclarationHandler>
@end

/// Provides functionality to apply an [A]RGB color to a UIButton.
@interface BBUIButtonColorHandler : BBColorHandler
@end

/// Provides functionality to apply an [A]RGB color to a UITabBar.
@interface BBUITabBarColorHandler : BBColorHandler
@end

#endif /* BBCOLORHANDLER_CLASS */
