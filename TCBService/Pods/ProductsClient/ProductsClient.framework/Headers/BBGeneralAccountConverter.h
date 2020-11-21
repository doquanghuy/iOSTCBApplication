//
//  Created by Backbase R&D B.V. on 24/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default general account product converter for converting a list of general account into a list of recipient models.
 * By default:
 * - Balance is assigned from booked balance of the product.
 * - Account number is assigned from IBAN number of the product.
 * For customising the implementation details for General Account product type, please extend the ProductConverterFactory.
 */
@interface BBGeneralAccountConverter : NSObject<BBProductConverter>

@end

