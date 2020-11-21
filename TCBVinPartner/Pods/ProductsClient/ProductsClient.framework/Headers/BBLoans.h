//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBLoans_h
#define ProductsClient_BBLoans_h

#import <ProductsClient/BBProductKind.h>
#import <ProductsClient/BBLoan.h>

NS_ASSUME_NONNULL_BEGIN

/// Loan product kind.
@interface BBLoans : Additions<BBProductKind>

/// The label/name that is used for the respective product kind.
@property (strong, nonatomic, readonly) NSString *name;

/// Defines a balance for the loans.
@property (strong, nonatomic, readonly, nullable) BBAggregatedBalance *aggregatedBalance;

/// Products for the loans.
@property (strong, nonatomic, readonly, nullable) NSArray<__kindof BBLoan*> *products;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBLoans_h */
