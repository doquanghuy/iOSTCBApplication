//
//  Created by Backbase R&D B.V. on 24/10/2019.
//

#import <CommonUtils/CommonUtils.h>

#ifndef BBProductsErrors_h
#define BBProductsErrors_h

/// Error domain for Products Client Errors
extern const NSErrorDomain _Nonnull BBProductsErrorDomain;
typedef NS_ENUM(NSInteger, BBProductsErrors) {
    
    /// Mandatory field should include at least one character.
    kBBProductsUnsupportedPayload = -1000
};

#endif /* BBProductsErrors_h */
