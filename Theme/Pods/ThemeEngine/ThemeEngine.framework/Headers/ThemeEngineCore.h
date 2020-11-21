//
//  ThemeEngineCore.h
//  Rorschach
//
//  Created by Backbase B.V. on 26/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#ifndef THEMEENGINE_CLASS
#define THEMEENGINE_CLASS

#import <ThemeEngine/ThemeEngine.h>

/// Options that can be used while applying a theme, the options are not mutually exclusive.
typedef NS_OPTIONS(NSUInteger, ApplyOptions) {
    /// Apply the theme with no options
    ApplyOptionsNone = 0,

    /// Apply the theme and generate debug information while doing so
    ApplyOptionsDebug = 1,

    /// Apply the theme by computing the ancestors' styles of the current view.
    ApplyOptionsComputeAncestorsStyle = 1 << 1,

    /// Apply the theme and keep track of changes on the hierarchy (add, remove, invalidations)
    ApplyOptionsTrackChanges = 1 << 2
};

/// Facade class to interact with the theme engine
@interface ThemeEngine : NSObject

/// Retrieves a shared instance of the theme engine
@property (class, readonly, nonatomic, nonnull) ThemeEngine* sharedThemeEngine;

/**
 * Default initializer is disabled in favor of the sharedThemeEngine.
 * @return always returns nil
 */
- (instancetype _Nonnull)init NS_UNAVAILABLE;

/**
 * Initializes a ThemeEngine instance with a parser and a file URL. This initializer will invoke the parser instance and
 * attempt to parse the file provided in the themeURL if any errors result from the parsing, the initializer will return
 * nil instead of an instance and the reason from the error in the error reference variable.
 * @param themeURL An URL with the location of the rules to be loaded.
 * @param parser A parser instance to generate the rules for this ThemeEngine
 * @param error Error reference to leave information about the failure.
 * @return A ThemeEngine instance if the parsing of the rules is successful. Nil otherwise.
 */
- (BOOL)loadFromURL:(NSURL* _Nonnull)themeURL
             parser:(NSObject<ThemeParser>* _Nonnull)parser
              error:(NSError* _Nullable* _Nullable)error;

/**
 * Initializes a ThemeEngine instance with a file URL using the default JSON parser.
 * @discussion alias of [self loadFromURL:themeURL parser:[[BBThemeEngineJSONParser alloc] init] error:error]
 * @param themeURL An URL with the location of the rules to be loaded.
 * @param error Error reference to leave information about the failure.
 * @return A ThemeEngine instance if the parsing of the rules is successful. Nil otherwise.
 */
- (BOOL)loadFromURL:(NSURL* _Nonnull)themeURL error:(NSError* _Nullable* _Nullable)error;

/**
 * Registers a DeclarationHandler implementation to be used whenever declaration affects the property over a view of the
 * given viewType is encounter.
 * @discussion If there is a DeclarationHandler already registered for the tuple (viewType, property) this method will
 * override it with the provided handler.
 * @param handler Implementation of a DeclarationHandler that will deal with the application of the style over a given
 * view
 * @param viewType Type view that will be affected by the DeclarationHandler
 * @param property Property name that will be modified by the DeclarationHandler
 * @return YES if the handler was successfully registered. NO if there was any error.
 */
- (BOOL) registerHandler:(NSObject<DeclarationHandler>* _Nonnull)handler
                     for:(Class _Nonnull)viewType
                property:(NSString* _Nonnull)property NS_SWIFT_NAME(register(handler:for:property:));

/**
 * Unregisters the DeclarationHandler associated to the tuple (viewType, property).
 * @param viewType Type view to look for.
 * @param property Property name to look for.
 * @return YES if the handler was successfully unregistered. NO if there was no registered handler for the tuple
 * (viewType, property)
 */
- (BOOL) unregisterHandlerFor:(Class _Nonnull)viewType
                     property:(NSString* _Nonnull)property NS_SWIFT_NAME(unregister(for:property:));

/**
 * Applies the rules provided by the parser over the given view. The view and its subviews are run through this process
 * and all changes are applied in-situ over the instances of the views.
 * @discussion Some options can be provide, such as to get debug information about the computed styles of each view
 * under and inclusive. Some relevant about the view itself is displayed (e.g. class, frame and if present the
 * accessibilityIdentifier)
 * @param view View to apply the theme over.
 * @param options Options to be used while applying the theme.
 */
- (void)applyThemeTo:(UIView* _Nonnull)view options:(ApplyOptions)options;

/**
 * Applies the rules provided by the parser over the given view. The view and its subviews are run through this process
 * and all changes are applied in-situ over the instances of the views.
 * @discussion This method is an alias of [self applyThemeTo:view options:ApplyOptionsNone]
 * @param view View to apply the theme over.
 */
- (void)applyThemeTo:(UIView* _Nonnull)view;

/**
 * Defines what declarations can be implicitly inherited when applying a theme.
 * @param inheritableDeclarations Set of names of those declarations that can be inherited automatically.
 */
- (void)setInheritableDeclarations:(NSSet<NSString*>* _Nonnull)inheritableDeclarations;
@end

#endif
