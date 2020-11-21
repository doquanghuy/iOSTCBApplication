//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef PaymentOrderClient_BBIdentification_h
#define PaymentOrderClient_BBIdentification_h

#import <CommonUtils/Additions.h>

#import <PaymentOrderClient/BBSchemeName.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBIdentification : Additions

/// The identifier of the account. Can be a regular account number, or an ID.
@property (nonatomic, strong, readonly) NSString *identification;

/// Specifies the kind of the account identifier
@property (nonatomic, strong, readonly) BBSchemeName schemeName;

- (instancetype)initWithIdentification:(NSString *)identification
                            schemeName:(BBSchemeName)schemeName;

@end

NS_ASSUME_NONNULL_END

#endif
