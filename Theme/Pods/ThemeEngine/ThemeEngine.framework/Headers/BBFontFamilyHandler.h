//
//  BBFontFamilyHandler.h
//  Rorschach
//
//  Created by Backbase B.V. on 27/03/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ThemeEngine/ThemeEngine.h>

#ifndef BBFONTFAMILYHANDLER_CLASS
#define BBFONTFAMILYHANDLER_CLASS

/// Provides functionality to apply a font family to a UILabel element.
@interface BBSimpleFontFamilyHandler : BBFontFamilyParser <DeclarationHandler>
@end

/// Provides functionality to apply a font family to a UIButton element.
@interface BBUIButtonFontFamilyHandler : BBFontFamilyParser <DeclarationHandler>
@end

#endif
