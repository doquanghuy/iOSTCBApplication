//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBCreditCards_h
#define ProductsClient_BBCreditCards_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBCreditCard.h>

NS_ASSUME_NONNULL_BEGIN

/// Credit card product kind.
@interface BBCreditCards : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the credit cards.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the credit cards.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBCreditCard*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBCreditCards_h */
