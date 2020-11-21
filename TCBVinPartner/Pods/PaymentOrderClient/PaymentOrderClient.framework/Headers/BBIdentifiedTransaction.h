//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef PaymentOrderClient_BBIdentifiedTransaction_h
#define PaymentOrderClient_BBIdentifiedTransaction_h

#import <CommonUtils/CommonUtils.h>
#import <PaymentOrderClient/BBInvolvedParty.h>
#import <PaymentOrderClient/BBCounterpartyAccount.h>
#import <PaymentOrderClient/BBBank.h>
#import <PaymentOrderClient/BBRemittanceInformation.h>

NS_ASSUME_NONNULL_BEGIN

/// Class defining the identified transaction, which means the creditor will have a arrangementId where applicable.
@interface BBIdentifiedTransaction : Additions

/// Instructed amount.
@property (nonatomic, strong, readonly) BBCurrency *instructedAmount;

/// This object is a common denominator for the debtor or creditor party.
@property (nonatomic, strong, readonly, nullable) BBInvolvedParty *counterparty;

/// The counterparty Account is the original account identification plus the arrangement if applicable.
@property (nonatomic, strong, readonly, nullable) BBCounterpartyAccount *counterpartyAccount;

/// Bank information of the counterparty
@property (nonatomic, strong, readonly, nullable) BBBank *counterpartyBank;

/// Bank information of the correspondent
@property (nonatomic, strong, readonly, nullable) BBBank *correspondentBank;

/// Bank information of the intermediary
@property (nonatomic, strong, readonly, nullable) BBBank *intermediaryBank;

/// The message to the bank used for US domestic wire payments.
@property (nonatomic, strong, readonly, nullable) NSString *messageToBank;

/// The alpha-3 code (complying with ISO 4217) of the currency.
@property (nonatomic, strong, readonly, nullable) NSString *targetCurrency;

/// This is the object representation of the remittance info and can contain different types of remittance info. It is only used in responses, not for input requests!
@property (nonatomic, strong, readonly, nullable) BBRemittanceInformation *remittanceInformation;

/// End to end identification.
@property (nonatomic, strong, readonly, nullable) NSString *endToEndIdentification;

@end

NS_ASSUME_NONNULL_END

#endif /* PaymentOrderClient_BBIdentifiedTransaction_h */
