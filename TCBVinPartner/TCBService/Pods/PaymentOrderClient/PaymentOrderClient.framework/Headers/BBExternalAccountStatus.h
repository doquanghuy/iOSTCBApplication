//
//  Created by Backbase R&D B.V. on 17/02/2020.
//

#ifndef BBExternalAccountStatus_h
#define BBExternalAccountStatus_h

#import <Foundation/Foundation.h>

/// The status in which an external account can be
typedef NSString *BBExternalAccountStatus NS_TYPED_ENUM;

/// The external account is active and can be used to create payment order
extern BBExternalAccountStatus const kBBExternalAccountStatusActive;

/// The external account is being verified
extern BBExternalAccountStatus const kBBExternalAccountStatusInProcess;

/// The external account is verified but not yet activated
extern BBExternalAccountStatus const kBBExternalAccountStatusPendingActivation;

/// The external account could not be verified
extern BBExternalAccountStatus const kBBExternalAccountStatusFailedVerification;

/// The external account was rejected by the bank
extern BBExternalAccountStatus const kBBExternalAccountStatusRejectedByExternalBank \
__attribute__((annotate("oclint:suppress[long parameter name]")));

/// The external account is disabled due to eccessive returns
extern BBExternalAccountStatus const kBBExternalAccountStatusDisabledForExcessiveReturns \
__attribute__((annotate("oclint:suppress[long parameter name]")));

/// The external account is disabled due to fraud
extern BBExternalAccountStatus const kBBExternalAccountStatusDisabledForFraud;

#endif
