//
//  Created by Backbase R&D B.V. on 18/02/2018.
//

#import <Foundation/Foundation.h>

#ifndef NSDictionary_Backbase_h
#define NSDictionary_Backbase_h

/// NSDictionary extension class that has convenience methods for key value pair operations.
@interface NSDictionary (Backbase)

/**
 Convert the keys and values of the dictionary to an array of query items.

 @return Array of NSURLQueryItem items
 */
- (NSArray <NSURLQueryItem *> * _Nullable)bb_queryItems;

/**
 Create a copy with all [NSNull null] values removed.
 
 @return The filtered NSDictionary
 */
- (NSDictionary * _Nonnull)bb_dictionaryByRemovingNullValues;

@end

#endif /* NSDictionary_Backbase_h */
