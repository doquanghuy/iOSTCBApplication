//
//  Created by Backbase R&D B.V. on 18.03.2020.
//

#ifndef BBTransactionCheckImages_h
#define BBTransactionCheckImages_h

#import <CommonUtils/CommonUtils.h>
#import <TransactionsClient/BBTransactionCheckImage.h>

NS_ASSUME_NONNULL_BEGIN

/// This class is a response class for a list of check images in a transaction.
@interface BBTransactionCheckImages : Additions

/// List of check images present in a specific transaction
@property (nonatomic, strong, nullable, readonly) NSArray<BBTransactionCheckImage*> *images;

@end

NS_ASSUME_NONNULL_END

#endif
