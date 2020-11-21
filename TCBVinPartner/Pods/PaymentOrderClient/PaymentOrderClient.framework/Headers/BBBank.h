//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBBank_h
#define PaymentOrderClient_BBBank_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBPostalAddress.h>

/// This object is used to identify the creditor or correspondent bank.
@interface BBBank : Additions

/// A bank branch can be identified from the (national) bank code. It differs from BIC and varies between countries (p.e. ABA routing transit number (9) or UK sortcode (6)).
@property (nonatomic, strong, readonly, nullable) NSString *bankBranchCode;

/// The name of a bank.
@property (nonatomic, strong, readonly, nullable) NSString *name;

/// The postal address of the bank.
@property (nonatomic, strong, readonly, nullable) BBPostalAddress *postalAddress;

/// Business identifier code as specified by ISO 9362:2014
@property (nonatomic, strong, readonly, nullable) NSString *bic;

- (nonnull instancetype)initWithBankBranchCode:(nullable NSString *)bankBranchCode
                                          name:(nullable NSString *)name
                                 postalAddress:(nullable BBPostalAddress *)postalAddress
                                           bic:(nullable NSString *)bic;

@end

#endif
