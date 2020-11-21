//
//  Created by Backbase R&D B.V. on 03/11/2018.
//

#import <Foundation/Foundation.h>

#ifndef BBTransactionTypeGroup_h
#define BBTransactionTypeGroup_h

typedef NSString *BBTransactionTypeGroup NS_TYPED_ENUM;

extern BBTransactionTypeGroup const kBBTransactionTypeGroupPayment;
extern BBTransactionTypeGroup const kBBTransactionTypeGroupWithdrawal;
extern BBTransactionTypeGroup const kBBTransactionTypeGroupLoans;
extern BBTransactionTypeGroup const kBBTransactionTypeGroupFees;

#endif
