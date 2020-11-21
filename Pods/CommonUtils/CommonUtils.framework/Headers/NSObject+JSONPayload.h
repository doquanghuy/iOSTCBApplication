//
//  Created by Backbase R&D B.V. on 15/03/2018.
//

#import <Foundation/Foundation.h>
#import "NSObject+JSONMapper.h"

#ifndef NSObject_JSONPayload_h
#define NSObject_JSONPayload_h

/// Converts a given object into a json payload.
@interface NSObject (JSONPayload)

/// Converts a given object into a json payload.
- (NSDictionary* _Nullable)JSONPayload;

@end

#endif
