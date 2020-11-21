//
//  Created by Backbase R&D B.V. on 05/04/2018.
//

#import <Foundation/Foundation.h>

#ifndef NSError_Backbase_h
#define NSError_Backbase_h

/// NSError extension class that has convenience methods for errors.
@interface NSError (Backbase)

/**
 Convert a NSError to a dictionary. This dictionary will not include all properties.
 Only the domain, code and localizedDescription will be added.

 @return A dictionary with domain, code and localizedDescription.
 */
- (NSDictionary * _Nullable)JSONObject;

@end

#endif

/* NSError_Backbase_h */
