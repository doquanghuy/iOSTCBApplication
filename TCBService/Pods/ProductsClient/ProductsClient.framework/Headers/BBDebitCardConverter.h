//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default debit card product converter for converting a list of debit cards into a list of recipient models.
 * By default account number is assigned from product number.
 * For customising the implementation details for Debit Card product type, please extend the ProductConverterFactory.
 */
@interface BBDebitCardConverter : NSObject<BBProductConverter>

@end

