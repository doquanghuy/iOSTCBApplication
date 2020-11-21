//
//  Created by Backbase R&D B.V. on 20/12/2017.
//

#import <Foundation/Foundation.h>

#ifndef BBCardNumberFormat_h
#define BBCardNumberFormat_h

NS_ASSUME_NONNULL_BEGIN

/// The configuration that determines how a payment card number should be formatted.
@interface BBCardNumberFormat : NSObject

/// Total length of the payment card number.
@property (nonatomic, readonly) NSUInteger length;

/// Start index of characters that should be masked.
@property (nonatomic, readonly) NSRange maskRange;

/// The array of sizes the segments should have.
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *segments;

/// Create custom card number format with custom segments
- (instancetype)initWithLength:(NSUInteger)length
                  maskingRange:(NSRange)maskRange
                      segments:(NSArray<NSNumber *> *)segments;

/// Create custom card number format with equel segments
- (instancetype)initWithLength:(NSUInteger)length
                  maskingRange:(NSRange)maskRange
                  segmentsSize:(NSNumber *)segmentsSize;

///  Default card number format. E.x. **** **** **** 1234
+ (BBCardNumberFormat *)defaultFormat;

///  Card number format for Mastercard. E.x. **** **** **** 1234
+ (BBCardNumberFormat *)mastercardFormat;

///  Card number format for Visa. E.x. **** **** **** 1234
+ (BBCardNumberFormat *)visaFormat;

///  Card number format for Visa Debit. E.x. **** **** **** 1234
+ (BBCardNumberFormat *)visaDebitFormat;

///  Card number format for Diners Club. E.x. **** ****** 1234
+ (BBCardNumberFormat *)dinersClubFormat;

///  Card number format for American Express. E.x. **** ****** *1234
+ (BBCardNumberFormat *)americanExpressFormat;

@end

@interface BBCardNumberFormatter : NSObject

/**
 * Formats a card number, mask it and split it into segments
 * @param value The string to transform
 * @param format The formatting configuration
 * @param maskChar The character to mask with
 */
+ (nullable NSString *)transformString:(NSString *)value
                              toFormat:(BBCardNumberFormat*)format
                         usingMaskChar:(NSString *)maskChar;

@end


NS_ASSUME_NONNULL_END

#endif
