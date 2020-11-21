# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

plugin 'cocoapods-art', sources: %w[
  backbase-pods3
  backbase-pods-retail3
]

use_frameworks!

def rx_swift
  pod 'RxSwift', '~> 5.0'
end

def tcb_service
  pod 'TCBService', :path => 'TCBService'
#  pod 'TCBService', :git => 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbservices.git', :tag => '1.0.2'
end

def domain
  pod 'Domain', :path => 'Domain'
#  pod 'TCBDomain', :git => 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbcore.git'
end

def tcb_vinpartner
  pod 'TCBVinPartner', :path => 'TCBVinPartner'
end

def tcb_components
  pod 'TCBComponents', :path => 'TCBComponents'
#  pod 'TCBComponents', :git => 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbcomponents.git'
end

def theme
  pod 'Theme', :path => 'Theme'
end

target 'FastMobile' do
  tcb_service
  domain
  tcb_vinpartner
  tcb_components
  theme
  rx_swift
  pod 'RxCocoa', '5'
  pod 'SwiftLint', '0.40.1'
  pod 'pop', '1.0.10'
  pod 'SnapKit', '5.0.0'
  pod 'IQKeyboardManagerSwift'
  pod "PromiseKit", "~> 6.8"
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'SkeletonView', '~> 1.10.0'
  pod 'Alamofire', '~> 5.2'
  pod 'Nuke', '~> 9.1.2'
  pod 'SWRevealViewController', '~> 2.3'
  pod 'lottie-ios'

  target 'FastMobileTests' do
    pod 'RxBlocking', '~> 5'
  end

  target 'FastMobileUITests' do
  end

end
