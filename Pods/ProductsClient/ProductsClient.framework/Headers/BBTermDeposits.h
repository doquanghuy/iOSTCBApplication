//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBTermDeposits_h
#define ProductsClient_BBTermDeposits_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBTermDeposit.h>

NS_ASSUME_NONNULL_BEGIN

/// Term deposit product kind.
@interface BBTermDeposits : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the term deposits.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the term deposits.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBTermDeposit*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBTermDeposits_h */
