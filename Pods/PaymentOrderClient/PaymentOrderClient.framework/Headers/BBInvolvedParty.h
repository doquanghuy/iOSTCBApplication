//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBInvolvedParty_h
#define PaymentOrderClient_BBInvolvedParty_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBPostalAddress.h>
#import <PaymentOrderClient/BBInvolvedPartyRole.h>

NS_ASSUME_NONNULL_BEGIN

/// This object is a common denominator for the debtor or creditor party.
@interface BBInvolvedParty : Additions

/// Name of the involved party.
@property (nonatomic, strong, readonly) NSString *name;

/// Postal address of the involved party.
@property (nonatomic, strong, readonly, nullable) BBPostalAddress *postalAddress;

/// Role that the involved party can have.
@property (nonatomic, assign, readonly, nullable) BBInvolvedPartyRole role;

- (instancetype)initWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name
               postalAddress:(nullable BBPostalAddress *)postalAddress;

- (instancetype)initWithName:(NSString *)name
               postalAddress:(nullable BBPostalAddress *)postalAddress
                        role:(nullable BBInvolvedPartyRole)role;

@end

NS_ASSUME_NONNULL_END

#endif
