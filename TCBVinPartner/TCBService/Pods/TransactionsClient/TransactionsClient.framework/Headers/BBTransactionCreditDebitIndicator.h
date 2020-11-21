//
//  Created by Backbase R&D B.V. on 22/10/2018.
//

#import <CommonUtils/CommonUtils.h>

#ifndef BBTransactionCreditDebitIndicator_h
#define BBTransactionCreditDebitIndicator_h

/// Transactions credit debit indicator. Raw values for credit: CRDT, for debit: DBIT
typedef NSString* BBTransactionCreditDebitIndicator NS_TYPED_ENUM;

extern BBTransactionCreditDebitIndicator const kBBTransactionCreditDebitIndicatorDebit;
extern BBTransactionCreditDebitIndicator const kBBTransactionCreditDebitIndicatorCredit;

#endif
