//
//  Created by Backbase R&D B.V. on 17/02/2020.
//

#ifndef BBExternalAccount_h
#define BBExternalAccount_h

#import <Foundation/Foundation.h>
#import <CommonUtils/Additions.h>
#import "BBExternalAccountType.h"

/// An object describing the basic information of an external bank account
@interface BBExternalAccount : Additions
  
/// Routing number of the bank
@property (nonatomic, copy, readonly, nonnull) NSString *routingNumber;

/// Account number of the bank account
@property (nonatomic, copy, readonly, nonnull) NSString *accountNumber;

///  The type of the external account
@property (nonatomic, strong, readonly, nonnull) BBExternalAccountType accountType;

/// The user-defined alias of the external account
@property (nonatomic, copy, readonly, nullable) NSString *accountNickName;

@end

#endif
