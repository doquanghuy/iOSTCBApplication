//
//  Created by Backbase R&D B.V. on 13/02/2018.
//

#import <Foundation/Foundation.h>

#ifndef IBANValidator_h
#define IBANValidator_h

/**
 Validate the IBAN number using all validation options.
 */
typedef NS_OPTIONS(NSUInteger, IBANValidationOptions) {
    IBANValidationOptionCheckDigit = 1 << 0, // compare the check digit with the calculated value of the IBAN
    IBANValidationOptionMinLength = 1 << 1, // validate the IBAN string length is not too short
    IBANValidationOptionMaxLength = 1 << 2, // validate the IBAN length does not exceed accepted length for given country
    IBANValidationOptionCharacters = 1 << 3, // validate the IBAN string only contains alpha-numeric chars
    IBANValidationOptionExactLength = 1 << 4, // validate the IBAN length is the same as the accepted length for given country
};

/// Convenience class for IBAN validation.
@interface IBANValidator : NSObject

/**
 Validate the IBAN number using all validation options.
 @return Boolean indicating whether the IBAN string is valid.
*/
+ (BOOL)isValidIBAN:(NSString *)iban;

/**
 Validate the IBAN number using the provided validation options.
 @return Boolean indicating whether the IBAN string is valid.
 */
+ (BOOL)isValidIBAN:(NSString *)iban validationOptions:(IBANValidationOptions)options;

@end

#endif /* IBANValidator_h */

