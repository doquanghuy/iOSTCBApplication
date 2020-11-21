//
//  ThemeCondition.h
//  Rorshach
//
//  Created by Backbase B.V. on 11/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThemeSelector;

#ifndef THEMECONDITION_CLASS
#define THEMECONDITION_CLASS

/**
 * Theme Condition data object
 * This class provides a generic representation of a condition to be checked.
 * Each condition has a list of matchers that will be used as ALL match.
 */
@interface ThemeCondition : NSObject

/**
 * Initializes the condition with the selectors for this condition
 * @param selectors Array of ThemeSelector implementations
 * @return A condition object
 */
- (instancetype _Nonnull)initWithSelectors:(NSArray<ThemeSelector*>* _Nonnull)selectors;

/**
 * Validates if the given view matches all matchers defined in this condition
 * @param view View to validate
 * @return YES if all matchers are satified by this view, NO otherwise.
 */
- (BOOL)matches:(UIView* _Nonnull)view;
@end

#endif
