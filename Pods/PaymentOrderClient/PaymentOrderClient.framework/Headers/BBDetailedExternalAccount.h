//
//  Created by Backbase R&D B.V. on 18/02/2020.
//

#ifndef BBDetailedExternalAccount_h
#define BBDetailedExternalAccount_h

#import "BBExternalAccount.h"
#import "BBExternalAccountStatus.h"

/// An object describing detailed information of an external bank account
@interface BBDetailedExternalAccount : BBExternalAccount

/// Account identifier in the A2A provider
@property (nonatomic, copy, readonly, nonnull) NSString *externalAccountId;

/// The name of the bank
@property (nonatomic, copy, readonly, nonnull) NSString *bankName;

/// The status of the external bank account
@property (nonatomic, copy, readonly, nonnull) BBExternalAccountStatus status;

/// Last part of the accountNumber to be used in a masked format
@property (nonatomic, copy, readonly, nullable) NSString *maskedAccountNumber;

@end

#endif
