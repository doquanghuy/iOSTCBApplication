//
//  ThemeEngine.h
//  Rorshach
//
//  Created by Backbase B.V. on 11/09/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENGINE_VERSION @"1.3.0"

// Theme structure
#import <ThemeEngine/ThemeMatcher.h>
#import <ThemeEngine/Theme.h>
#import <ThemeEngine/ThemeRule.h>
#import <ThemeEngine/ThemeCondition.h>
#import <ThemeEngine/ThemeSelector.h>

// matchers
#import <ThemeEngine/BBTypeMatcher.h>
#import <ThemeEngine/BBThemeClassMatcher.h>

// parsers
#import <ThemeEngine/ThemeParser.h>
#import <ThemeEngine/BBThemeEngineJSONParser.h>
#import <ThemeEngine/BBThemeEngineCSSParser.h>

// declaration handlers
#import <ThemeEngine/DeclarationHandler.h>
#import <ThemeEngine/BBColorParser.h>
#import <ThemeEngine/BBBackgroundColorHandler.h>
#import <ThemeEngine/BBFontFamilyParser.h>
#import <ThemeEngine/BBFontFamilyHandler.h>
#import <ThemeEngine/BBBackgroundImageParser.h>
#import <ThemeEngine/BBBackgroundImageHandler.h>
#import <ThemeEngine/BBColorHandler.h>
#import <ThemeEngine/BBBorderRadiusParser.h>
#import <ThemeEngine/BBBorderRadiusHandler.h>

// engine core
#import <ThemeEngine/ThemeEngineCore.h>

/// Supported out-of-the-box declarations
typedef NSString* BBDeclaration NS_TYPED_ENUM;

/// Background color
extern BBDeclaration const kBBDeclarationBackgroundColor;
