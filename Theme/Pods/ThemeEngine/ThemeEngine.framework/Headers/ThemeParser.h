//
//  ThemeParser.h
//  Rorshach
//
//  Created by Backbase B.V. on 11/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Theme;

/// Conforming object will provide a way to translate specific formats into a neutral data structure that is understood
/// by the Theme Engine.
@protocol ThemeParser <NSObject>

/**
 * Conforming object provides a method that allows to turn the given file into an array of ThemeRules (also known as a
 * ruleset).
 * @param themeData The data of the file where the theme rules should be read from.
 * @param error Error object to inform of any possible failure during the parsing.
 * @return Theme object resulting of the translation or nil in case of error.
 *
 * @discussion It is up to the parser implementation determine the resiliency level expected of the parser, some parsers
 * could opt for ignore misformed rules and only translate the well formed ones. Other parsers could be more strict and
 * simply fail when expected tokens are found. In the latter cases, the expected the error object to be populated with
 * meaningful error messages.
 */
- (Theme* _Nullable)parse:(NSData* _Nonnull)themeData error:(NSError* _Nullable* _Nullable)error;
@end
