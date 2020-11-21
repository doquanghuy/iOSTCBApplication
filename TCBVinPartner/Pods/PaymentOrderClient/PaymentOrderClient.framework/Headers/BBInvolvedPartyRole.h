//
//  Created by Backbase R&D B.V. on 28/04/2020.
//

#ifndef  BBInvolvedPartyRole_h
#define  BBInvolvedPartyRole_h

#import <Foundation/Foundation.h>

//Role that the involved party can have
typedef NSString *BBInvolvedPartyRole NS_TYPED_ENUM;

extern BBInvolvedPartyRole const kBBInvolvedPartyRoleCreditor;
extern BBInvolvedPartyRole const kBBInvolvedPartyRoleDebtor;

#endif
