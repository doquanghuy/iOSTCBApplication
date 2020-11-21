//
//  Created by Backbase R&D B.V. on 18.03.2020.
//

#ifndef BBTransactionCheckImage_h
#define BBTransactionCheckImage_h

#import <CommonUtils/CommonUtils.h>
#import <TransactionsClient/BBTransactionCheckImageSide.h>
#import <TransactionsClient/BBTransactionCheckImageType.h>

NS_ASSUME_NONNULL_BEGIN

/// This class is a response class for single side of a check image.
@interface BBTransactionCheckImage : Additions

/// Indicates side of the check image.
@property (nonatomic, nonnull, readonly) BBTransactionCheckImageSide side;

/// Image type of the check image.
@property (nonatomic, nonnull, readonly) BBTransactionCheckImageType mimeType;

/// Base64 image representation of the check image
@property (strong, nonatomic, nonnull, readonly) NSString *content;

/// Returns an image presentation of the given base64 content.
-(nullable UIImage*)checkImage;

@end

NS_ASSUME_NONNULL_END

#endif
