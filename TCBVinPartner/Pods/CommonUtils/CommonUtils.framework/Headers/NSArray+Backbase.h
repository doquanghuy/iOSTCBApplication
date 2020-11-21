//
//  Created by Backbase R&D B.V. on 12/04/2018.
//

#import <Foundation/Foundation.h>

#ifndef NSArray_Backbase_h
#define NSArray_Backbase_h

/// NSArray extension class that has convenience methods for arrays.
@interface NSArray (Backbase)

/**
 Create a copy with all [NSNull null] values removed.
 @return The filtered array.
*/
- (NSArray * _Nonnull)bb_arrayByRemovingNullValues;

@end

#endif /* NSArray_Backbase_h */
