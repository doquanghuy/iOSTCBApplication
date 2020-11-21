//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBInitiateTransaction_h
#define PaymentOrderClient_BBInitiateTransaction_h

#import <CommonUtils/CommonUtils.h>
#import <PaymentOrderClient/BBInvolvedParty.h>
#import <PaymentOrderClient/BBInitiateCounterpartyAccount.h>
#import <PaymentOrderClient/BBBank.h>

NS_ASSUME_NONNULL_BEGIN

/// Class that is defining the credit transaction to be initiated.
@interface BBInitiateTransaction : Additions

@property (nonatomic, strong, readonly) BBCurrency *instructedAmount;

/// This object is a common denominator for the debtor or creditor party.
@property (nonatomic, strong, readonly, nullable) BBInvolvedParty *counterparty;

/// The counterparty Account is the original account identification plus the type of account if applicable.
@property (nonatomic, strong, readonly, nullable) BBInitiateCounterpartyAccount *counterpartyAccount;

/// This object is used to identify the counterparty or correspondent bank.
@property (nonatomic, strong, readonly, nullable) BBBank *counterpartyBank;

/// Financial institution that provides services like facilitating wire transfers, conduct business transactions and accept deposits on behalf of another financial institution.
@property (nonatomic, strong, readonly, nullable) BBBank *correspondentBank;

/// The bank that acts on behalf of the beneficiary bank. Payments will reach the intermediary bank before being credited to the beneficiary which is the final destination for the transfer.
@property (nonatomic, strong, readonly, nullable) BBBank *intermediaryBank;

/// The message to the bank used for US domestic wire payments.
@property (nonatomic, strong, readonly, nullable) NSString *messageToBank;

/// The alpha-3 code (complying with ISO 4217) of the currency.
@property (nonatomic, strong, readonly, nullable) NSString *targetCurrency;

/// The remittance info for manually initiated credit transfers. Does not have a type since it will always default to UNSTRUCTURED.
@property (nonatomic, strong, readonly, nullable) NSString *remittanceInformation;

@property (nonatomic, strong, readonly, nullable) NSString *endToEndIdentification;

- (instancetype)init NS_UNAVAILABLE;

/**
 * Create a new BBInitiateTransaction object.
 * @param instructedAmount BBAccountIdentification which is the identified originator account with arrangement id.
 * @return Initialised BBInitiateTransaction object.
 */
- (instancetype)initWithInstructedAmount:(BBCurrency *)instructedAmount;

/**
 * Create a new BBInitiateTransaction object.
 * @param instructedAmount BBCurrency specifying the amount for the transaction.
 * @param counterparty BBInvolvedParty, common denominator for the debtor or creditor party.
 * @param counterpartyAccount BBInitiateCounterpartyAccount specifying the original account identification plus the type of account if applicable.
 * @param counterpartyBank BBBank used to identify the counterparty or correspondent bank.
 * @param correspondentBank BBBank specyfing a financial institution that provides services like facilitating wire transfers,
 * conduct business transactions and accept deposits on behalf of another financial institution.
 * @param intermediaryBank BBBank that acts on behalf of the beneficiary bank.
 * @param messageToBank NSString representing the message to the bank used for US domestic wire payments.
 * @param targetCurrency NSString, the alpha-3 code (complying with ISO 4217) of the currency.
 * @param remittanceInformation NSString sprecifying the info for manually initiated credit transfers.
 * @param endToEndIdentification NSString specifying endToEndIdentification
 * @return Initialised BBInitiateTransaction object.
 */
- (instancetype)initWithInstructedAmount:(BBCurrency *)instructedAmount
                            counterparty:(nullable BBInvolvedParty *)counterparty
                     counterpartyAccount:(nullable BBInitiateCounterpartyAccount *)counterpartyAccount
                        counterpartyBank:(nullable BBBank *)counterpartyBank
                       correspondentBank:(nullable BBBank *)correspondentBank
                        intermediaryBank:(nullable BBBank *)intermediaryBank
                           messageToBank:(nullable NSString *)messageToBank
                          targetCurrency:(nullable NSString *)targetCurrency
                   remittanceInformation:(nullable NSString *)remittanceInformation
                  endToEndIdentification:(nullable NSString *)endToEndIdentification;

@end

NS_ASSUME_NONNULL_END

#endif /* PaymentOrderClient_BBInitiateTransaction_h */
