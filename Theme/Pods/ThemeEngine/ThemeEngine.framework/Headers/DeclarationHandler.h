//
//  DeclarationHandler.h
//  Rorschach
//
//  Created by Backbase B.V. on 19/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef DECLARATIONHANDLE_PROTOCOL
#define DECLARATIONHANDLE_PROTOCOL

/// Conforming object will provide a way to apply the given declaration into a specific type of objects
/// @discussion This protocol allows to provide implementation for applying attributes into objects that differ from
/// others. e.g. applying borders to textfields it might be different that to buttons, or generic views. Moreover, this
/// provides an extension point for more sophisticated types of styles in the future.
@protocol DeclarationHandler <NSObject>
/**
 * Conforming object applies the value provided into the property provided over the view object provided.
 * @discussion The value provided needs to be parsed by the implementation to make sense of the data in it. Likewise,
 * the property parameter is informational, the implementation might be specific for a single property (and hence not
 * relevant)
 *
 * @param value Raw data provided by the declaration.
 * @param property Property that is expected to be modified on the view
 * @param view View to be modified as result of applying the style
 * @return YES if the view got modified as the result of this method. NO if the view did not change at all.
 */
- (BOOL)apply:(NSString* _Nonnull)value over:(NSString* _Nullable)property to:(UIView* _Nonnull)view;
@end

#endif
