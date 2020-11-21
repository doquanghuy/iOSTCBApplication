//
//  Created by Backbase R&D B.V. on 18.03.2020.
//

#ifndef BBTransactionCheckImageAvailability_h
#define BBTransactionCheckImageAvailability_h

#import <CommonUtils/CommonUtils.h>

/// Transaction check image availability indicator. Raw values for available: AVAILABLE, for unavailable: UNAVAILABLE
typedef NSString* BBTransactionCheckImageAvailability NS_TYPED_ENUM;

extern BBTransactionCheckImageAvailability const kBBTransactionCheckImageAvailabilityAvailable;
extern BBTransactionCheckImageAvailability const kBBTransactionCheckImageAvailabilityUnavailable;

#endif
