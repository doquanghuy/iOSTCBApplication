//
//  BBTypeMatcher.h
//  Rorschach
//
//  Created by Backbase B.V. on 28/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBTYPEMATCHER_CLASS
#define BBTYPEMATCHER_CLASS

/// Provides a matcher implementation to check if the given view is strictly equal to the given value.
@interface BBTypeMatcher : NSObject <ThemeMatcher>
@end

#endif
