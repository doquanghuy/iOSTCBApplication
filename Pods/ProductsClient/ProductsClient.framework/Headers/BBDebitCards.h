//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBDebitCards_h
#define ProductsClient_BBDebitCards_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBDebitCard.h>

NS_ASSUME_NONNULL_BEGIN

/// Debit card product kind.
@interface BBDebitCards : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the debit cards.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the debit cards.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBDebitCard*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBDebitCards_h */
