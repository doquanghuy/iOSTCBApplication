//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBExternalAccountType_h
#define BBExternalAccountType_h

#import <Foundation/Foundation.h>

/// The type of the account.
typedef NSString *BBExternalAccountType NS_TYPED_ENUM;

/// The type of a checking account
extern BBExternalAccountType const kBBExternalAccountTypeChecking;

/// The type of a saving account
extern BBExternalAccountType const kBBExternalAccountTypeSaving;

#endif
