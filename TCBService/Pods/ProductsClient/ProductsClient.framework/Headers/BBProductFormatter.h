//
//  Created by Backbase R&D B.V. on 12/09/2019.
//

#ifndef ProductsClient_BBProductFormatter_h
#define ProductsClient_BBProductFormatter_h

#import <Foundation/Foundation.h>

/// ProductFormatter protocol. The confoming object will have the ability to format different kinds of data.
@protocol BBProductFormatter <NSObject>

/**
 * Formats an IBAN number.
 * @param ibanNumber String with the IBAN number, assumes non-space characters.
 * @return A formatted IBAN string
 */
- (NSString*)formatIBAN:(NSString*)ibanNumber;

/**
 * Formats an BBAN number.
 * @param bbanNumber String with the BBAN number, assumes non-space characters.
 * @return A formatted BBAN string
 */
- (NSString*)formatBBAN:(NSString*)bbanNumber;

/**
 * Formats an account number.
 * @param accountNumber String with the account number, assumes non-space characters.
 * @return A formatted account string
 */
- (NSString*)formatAccountNumber:(NSString*)accountNumber;

/**
 * Formats a balance amount.
 * @param amount String of the amount to format.
 * @param currencyCode String with the currency code to use, for instance: EUR, USD, GBP
 * @return A formatted balance string following the locale specifications
 */
- (NSString*)formatAmount:(NSString*)amount currency:(NSString*)currencyCode;

/**
 * Formats a balance amount.
 * @param amount NSDecimalNumber of the amount to format.
 * @param currencyCode String with the currency code to use, for instance: EUR, USD, GBP
 * @return A formatted balance string following the locale specifications
 */
- (NSString*)formatDecimalAmount:(NSDecimalNumber*)amount currency:(NSString*)currencyCode;

@end


#endif /* ProductsClient_BBProductFormatter_h */
