//
//  BBThemeClassMatcher.h
//  Rorschach
//
//  Created by Backbase B.V. on 09/10/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBTHEMECLASSMATCHER_CLASS
#define BBTHEMECLASSMATCHER_CLASS

/// Provides a matcher implementation to check if the given view contains a specific class in the
/// accessibilityIdentifier.
@interface BBThemeClassMatcher : NSObject <ThemeMatcher>
@end

#endif
