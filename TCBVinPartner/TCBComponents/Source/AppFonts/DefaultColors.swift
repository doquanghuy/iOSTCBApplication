//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

public struct DefaultColors: AppColors {
    public var primary: UIColor
    public var primaryLighter: UIColor
    public var primaryLight: UIColor
    public var primaryDark: UIColor
    public var primaryDarker: UIColor
    public var primaryDarkest: UIColor
    public var secondary: UIColor
    public var secondaryDark: UIColor
    public var secondaryDarker: UIColor
    public var secondaryLime: UIColor
    public var secondaryTeal: UIColor
    public var secondaryLightBlue: UIColor
    public var secondaryLightBlueDarker: UIColor
    public var secondaryIndigo: UIColor
    public var secondaryPurple: UIColor
    public var secondaryPink: UIColor
    public var secondaryYellow: UIColor
    public var secondaryTango: UIColor
    public var secondaryOrange: UIColor
    public var secondaryGrey: UIColor
    public var supportWarning: UIColor
    public var supportDanger: UIColor
    public var supportInfo: UIColor
    public var supportSuccess: UIColor
    public var supportDangerDark: UIColor
    public var supportDangerDarker: UIColor
    public var supportSuccessDark: UIColor
    public var supportSuccessDarker: UIColor
    public var white: UIColor
    public var almostWhite: UIColor
    public var slightlyLightGrey: UIColor
    public var almostGrey: UIColor
    public var almostLightGrey: UIColor
    public var lightGrey: UIColor
    public var grey: UIColor
    public var midGrey: UIColor
    public var darkGrey: UIColor
    public var almostBlack: UIColor
    
    public init(
        /// "#00569C"
        primary: UIColor = #colorLiteral(red: 0, green: 0.337254902, blue: 0.6117647059, alpha: 1),
        /// "#107BB5"
        primaryLighter: UIColor = #colorLiteral(red: 0.06274509804, green: 0.4823529412, blue: 0.7098039216, alpha: 1),
        /// "#086BA8"
        primaryLight: UIColor = #colorLiteral(red: 0.03137254902, green: 0.4196078431, blue: 0.6588235294, alpha: 1),
        /// "#004285"
        primaryDark: UIColor = #colorLiteral(red: 0, green: 0.2588235294, blue: 0.5215686275, alpha: 1),
        /// "#00306B"
        primaryDarker: UIColor = #colorLiteral(red: 0, green: 0.1882352941, blue: 0.4196078431, alpha: 1),
        /// "#001D52"
        primaryDarkest: UIColor = #colorLiteral(red: 0, green: 0.1137254902, blue: 0.3215686275, alpha: 1),
        /// "#DDE4E9"
        secondary: UIColor = #colorLiteral(red: 0.8666666667, green: 0.8941176471, blue: 0.9137254902, alpha: 1),
        /// "#CCD3D8"
        secondaryDark: UIColor = #colorLiteral(red: 0.8, green: 0.8274509804, blue: 0.8470588235, alpha: 1),
        /// "#B3B8BD"
        secondaryDarker: UIColor = #colorLiteral(red: 0.7019607843, green: 0.7215686275, blue: 0.7411764706, alpha: 1),
        /// "#94C052"
        secondaryLime: UIColor = #colorLiteral(red: 0.5803921569, green: 0.7529411765, blue: 0.3215686275, alpha: 1),
        /// "#12B886"
        secondaryTeal: UIColor = #colorLiteral(red: 0.07058823529, green: 0.7215686275, blue: 0.5254901961, alpha: 1),
        /// "#74C0FC"
        secondaryLightBlue: UIColor = #colorLiteral(red: 0.4549019608, green: 0.7529411765, blue: 0.9882352941, alpha: 1),
        /// "#2B9CE0"
        secondaryLightBlueDarker: UIColor = #colorLiteral(red: 0.17, green: 0.61, blue: 0.88, alpha: 1.00),
        /// "#4259C5"
        secondaryIndigo: UIColor = #colorLiteral(red: 0.2588235294, green: 0.3490196078, blue: 0.7725490196, alpha: 1),
        /// "#883D9A"
        secondaryPurple: UIColor = #colorLiteral(red: 0.5333333333, green: 0.2392156863, blue: 0.6039215686, alpha: 1),
        /// "#D24887"
        secondaryPink: UIColor = #colorLiteral(red: 0.8235294118, green: 0.2823529412, blue: 0.5294117647, alpha: 1),
        /// "#FFD43B"
        secondaryYellow: UIColor = #colorLiteral(red: 1, green: 0.831372549, blue: 0.231372549, alpha: 1),
        /// "#FD7E14"
        secondaryTango: UIColor = #colorLiteral(red: 0.9921568627, green: 0.4941176471, blue: 0.07843137255, alpha: 1),
        /// "#E8590C"
        secondaryOrange: UIColor = #colorLiteral(red: 0.9098039216, green: 0.3490196078, blue: 0.04705882353, alpha: 1),
        /// "#6B6E70"
        secondaryGrey: UIColor = #colorLiteral(red: 0.42, green: 0.43, blue: 0.44, alpha: 1.00),
        /// "#F1BE3C"
        supportWarning: UIColor = #colorLiteral(red: 0.9450980392, green: 0.7450980392, blue: 0.2352941176, alpha: 1),
        /// "#BA293A"
        supportDanger: UIColor = #colorLiteral(red: 0.7294117647, green: 0.1607843137, blue: 0.2274509804, alpha: 1),
        /// "#1971C2"
        supportInfo: UIColor = #colorLiteral(red: 0.09803921569, green: 0.4431372549, blue: 0.7607843137, alpha: 1),
        /// "#00884B"
        supportSuccess: UIColor = #colorLiteral(red: 0, green: 0.5333333333, blue: 0.2941176471, alpha: 1),
        /// "#A61C23"
        supportDangerDark: UIColor = #colorLiteral(red: 0.6509803922, green: 0.1098039216, blue: 0.137254902, alpha: 1),
        /// "#910F0F"
        supportDangerDarker: UIColor = #colorLiteral(red: 0.568627451, green: 0.05882352941, blue: 0.05882352941, alpha: 1),
        /// "#007034"
        supportSuccessDark: UIColor = #colorLiteral(red: 0, green: 0.4392156863, blue: 0.2039215686, alpha: 1),
        /// "#005C25"
        supportSuccessDarker: UIColor = #colorLiteral(red: 0, green: 0.3607843137, blue: 0.1450980392, alpha: 1),
        /// "#FFFFFF"
        white: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        /// "#F8F9FA"
        almostWhite: UIColor = #colorLiteral(red: 0.9725490196, green: 0.9764705882, blue: 0.9803921569, alpha: 1),
        /// "#F1F6FB"
        slightlyLightGrey: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9647058824, blue: 0.9843137255, alpha: 1),
        /// "#DDE4E9"
        almostLightGrey: UIColor = #colorLiteral(red: 0.8666666667, green: 0.8941176471, blue: 0.9137254902, alpha: 1),
        /// "#E9EFF4"
        almostGrey: UIColor = #colorLiteral(red: 0.9137254902, green: 0.937254902, blue: 0.9568627451, alpha: 1),
        /// "#CCD3D8"
        lightGrey: UIColor = #colorLiteral(red: 0.8, green: 0.8274509804, blue: 0.8470588235, alpha: 1),
        /// "#B3B8BD"
        grey: UIColor = #colorLiteral(red: 0.7019607843, green: 0.7215686275, blue: 0.7411764706, alpha: 1),
        /// "#8C9194"
        midGrey: UIColor = #colorLiteral(red: 0.5490196078, green: 0.568627451, blue: 0.5803921569, alpha: 1),
        /// "#55585A"
        darkGrey: UIColor = #colorLiteral(red: 0.3333333333, green: 0.3450980392, blue: 0.3529411765, alpha: 1),
        /// "#111112"
        almostBlack: UIColor = #colorLiteral(red: 0.06666666667, green: 0.06666666667, blue: 0.07058823529, alpha: 1)
    ) {
        self.primary = primary
        self.primaryLighter = primaryLighter
        self.primaryLight = primaryLight
        self.primaryDark = primaryDark
        self.primaryDarker = primaryDarker
        self.primaryDarkest = primaryDarkest
        self.secondary = secondary
        self.secondaryDark = secondaryDark
        self.secondaryDarker = secondaryDarker
        self.secondaryLime = secondaryLime
        self.secondaryTeal = secondaryTeal
        self.secondaryLightBlue = secondaryLightBlue
        self.secondaryLightBlueDarker = secondaryLightBlueDarker
        self.secondaryIndigo = secondaryIndigo
        self.secondaryPurple = secondaryPurple
        self.secondaryPink = secondaryPink
        self.secondaryYellow = secondaryYellow
        self.secondaryTango = secondaryTango
        self.secondaryOrange = secondaryOrange
        self.secondaryGrey = secondaryGrey
        self.supportWarning = supportWarning
        self.supportDanger = supportDanger
        self.supportInfo = supportInfo
        self.supportSuccess = supportSuccess
        self.supportDangerDark = supportDangerDark
        self.supportDangerDarker = supportDangerDarker
        self.supportSuccessDark = supportSuccessDark
        self.supportSuccessDarker = supportSuccessDarker
        self.white = white
        self.almostWhite = almostWhite
        self.slightlyLightGrey = slightlyLightGrey
        self.almostGrey = almostGrey
        self.almostLightGrey = almostLightGrey
        self.lightGrey = lightGrey
        self.grey = grey
        self.midGrey = midGrey
        self.darkGrey = darkGrey
        self.almostBlack = almostBlack
    }
}
