//
//  BBThemeEngineCSSParser.h
//  Rorschach
//
//  Created by Backbase B.V. on 02/04/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBCSSPARSER_CLASS
#define BBCSSPARSER_CLASS

NS_ASSUME_NONNULL_BEGIN

/// Error Domain constant for this parser
extern const NSErrorDomain BBThemeEngineCSSParserErrorDomain;
typedef NS_ENUM(NSInteger, BBThemeEngineCSSParserErrors) {
    /// Has been a problem readin the rule file
    kBBThemeEngineCSSParserErrorIOError = -1000,
    /// Has been a problem during the CSS parsing of the file
    kBBThemeEngineCSSParserErrorInvalidCSS = -1001,
};

@interface BBThemeEngineCSSParser : NSObject <ThemeParser>

/**
 * Creates a parser with an explicit mapping between elements and iOS classes.
 * @discussion Using this mapping will allow to share the same CSS file between platforms by creating your own
 * CSS <i>elements</i> and explicitly mapping them to a platform specific class. For instance, your CSS can contain a
 * rule as: <pre> label .submit { background-color: #0000dd; } </pre>
 * And you can specify how to map the <i>label</i> element. You could create the following mapping
 * @{ @"label": @"UILabel" }, or @{ @"label": @"MyAwesomeLabel" }.
 * When providing the mapping you can decide to override the default mapping (see <i>init</i> constructor) by setting
 * override to true. Or to append the given values to the default mapping when setting override to false. In case of
 * collisions when setting override to false, it will give priority to the values on the given mapping over the default
 * mapping.
 * @param mapping A dictionary with the mapping between elements present in the CSS and their respective iOS classes.
 * @param override Force to use the given mapping as single source of truth.
 * @return a new CSS parser instance
 */
- (instancetype _Nonnull)initWithMatcherMapping:(NSDictionary<NSString*, NSString*>* _Nonnull)mapping
                                       override:(BOOL)override;

/**
 * Creates a parser without an explicit mapping.
 * @discussion This constructor creates a default mapping for the most common HTML elements that have a clear native
 * counterpart:
 * <ul>
 * <li>label -> UILabel</li>
 * <li>button -> UIButton</li>
 * <li>textarea -> UITextView</li>
 * <li>img -> UIImageView</li>
 * <li>nav-bar -> UINavigationBar</li>
 * <li>tab-bar -> UITabBar</li>
 * </ul>
 * @return a new CSS parser instance
 */
- (instancetype _Nonnull)init;
@end

NS_ASSUME_NONNULL_END

#endif
