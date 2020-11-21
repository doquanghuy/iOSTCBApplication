//
//  ThemeSelector.h
//  Rorschach
//
//  Created by Backbase B.V. on 06/11/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ThemeMatcher;

#ifndef THEMESELECTOR_CLASS
#define THEMESELECTOR_CLASS

/**
 * Theme Selector data object.
 * A selector defines a pair (matcher, expected value) which allows to determine if a given view matches the conditions
 * defined in this selector.
 */
@interface ThemeSelector : NSObject

/**
 * Initializes a selector with a matcher and the value to be consumed by this matcher (as expected value).
 * @param matcher A ThemeMatcher instance to be use when executing this selector.
 * @param value Additional input for the matcher, typically used to validate if the given view matches certain
 * requirements.
 * @return A new ThemeSelector instance
 */
- (instancetype _Nonnull)initWithMatcher:(NSObject<ThemeMatcher>* _Nonnull)matcher value:(NSString* _Nonnull)value;

/**
 * Validates if the given view complies with the matcher expectations.
 * @param view A give to validate.
 */
- (BOOL)matches:(UIView* _Nonnull)view;

@end

#endif
