//
//  Created by Backbase R&D B.V. on 27/03/2018.
//

#import <Foundation/Foundation.h>

#ifndef Additions_h
#define Additions_h

/// The class that allows users to pass additional data to the clients.
@interface Additions : NSObject

/**
 * Any class that extends from the Additions class, will have access to the the additions property.
 * The additions property allows users to pass additional data to the clients.
*/
@property (strong, nonatomic, readwrite, nullable) NSDictionary *additions;

@end

#endif
