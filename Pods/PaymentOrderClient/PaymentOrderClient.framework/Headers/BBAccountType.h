//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBAccountType_h
#define BBAccountType_h

#import <Foundation/Foundation.h>

/// The type of the account.
typedef NSString *BBAccountType NS_TYPED_ENUM;

extern BBAccountType const kBBAccountTypeChecking;
extern BBAccountType const kBBAccountTypeSaving;

#endif
