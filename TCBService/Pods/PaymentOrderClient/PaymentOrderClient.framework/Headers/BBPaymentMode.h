//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBPaymentMode_h
#define BBPaymentMode_h

#import <Foundation/NSString.h>

/// Denotes whether payment will be single or will be recurring
typedef NSString *BBPaymentMode NS_TYPED_ENUM;

extern BBPaymentMode const kBBPaymentModeSingle;
extern BBPaymentMode const kBBPaymentModeRecurring;

#endif
