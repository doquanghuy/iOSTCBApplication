//
//  ThemeMatcher.h
//  Rorshach
//
//  Created by Backbase B.V. on 11/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef THEMEMATCHER_PROTOCOL
#define THEMEMATCHER_PROTOCOL

/// Conforming object will provide a way to verify views matches an specific criteria
@protocol ThemeMatcher <NSObject>

/**
 * Conforming object verifies if the given view matches the criteria specified in the condition.
 * @discussion conditions are open strings that might be format dependent, and hence matcher could also be format
 * dependent.
 * @param value String with the raw information necessary to verify the match
 * @param view View to check against
 * @return Boolean if the view matches the criteria or not.
 */
- (BOOL)matches:(NSString* _Nonnull)value view:(UIView* _Nonnull)view;

@end

#endif
