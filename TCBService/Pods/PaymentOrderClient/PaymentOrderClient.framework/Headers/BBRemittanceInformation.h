//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef PaymentOrderClient_BBRemittanceInformation_h
#define PaymentOrderClient_BBRemittanceInformation_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBRemittanceType.h>

NS_ASSUME_NONNULL_BEGIN

/// This is the object representation of the remittance info and can contain different types of remittance info. It is only used in responses, not for input requests!
@interface BBRemittanceInformation : Additions

/// When type is structured it consists of some XML tags used when the transaction was uploaded.
@property (nonatomic, strong, readonly) BBRemittanceType type;

/// The content of the remittance information.
@property (nonatomic, strong, readonly) NSString *content;

@end

NS_ASSUME_NONNULL_END

#endif
