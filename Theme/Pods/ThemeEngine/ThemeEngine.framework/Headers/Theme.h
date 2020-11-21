//
//  Theme.h
//  Rorschach
//
//  Created by Backbase B.V. on 09/10/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef THEME_CLASS
#define THEME_CLASS
@class ThemeRule;

/// Class containing the information that defines a Theme (rules and how declarations are inherited)
@interface Theme : NSObject

/// Names of those declarations that should be inherited implicitly. By default all declaration are non-inheritable.
@property (copy, nonatomic, readwrite, nonnull) NSSet<NSString*>* inheritableDeclarations;

/**
 * Initializes a theme object with the array of rules and a set of inheritable declarations.
 * @param rules Array of ThemeRules that define this theme.
 * @param inheritableDeclarations Set of names of declarations that must automatically be inherited.
 * @return A Theme object.
 */
- (instancetype _Nonnull)initWithRules:(NSArray<ThemeRule*>* _Nonnull)rules
               inheritableDeclarations:(NSSet<NSString*>* _Nonnull)inheritableDeclarations;

/**
 * Initializes a theme object only with rules. All declarations are non-inheritable.
 * @discussion Alias of [self initWithRules:rules inheritableDeclarations:set]
 * @param rules Array of ThemeRules that define this theme.
 * @return A Theme object.
 */
- (instancetype _Nonnull)initWithRules:(NSArray<ThemeRule*>* _Nonnull)rules;
@end

#endif
