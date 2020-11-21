//
//  BBBackgroundColorHandler.h
//  Rorschach
//
//  Created by Backbase B.V. on 26/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBBACKGROUNDCOLORHANDLER_CLASS
#define BBBACKGROUNDCOLORHANDLER_CLASS

/// Provides functionality to apply an [A]RGB color to a unspecialized view element.
@interface BBBackgroundColorHandler : BBColorParser <DeclarationHandler>
@end

/// Provides functionality to apply an [A]RGB color to a Bar type (UISearchBar, UINavigationBar, UITabBar)
@interface BBBarBackgroundColorHandler : BBBackgroundColorHandler
@end

#endif
