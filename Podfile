# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'
source 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbservicespecs.git'
source 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbcorespecs.git'
source 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbvinpartnerspecs.git'
source 'https://bitbucket.techcombank.com.vn/scm/toreombb/iostcbcomponentspecs.git'

plugin 'cocoapods-art', sources: %w[
  backbase-pods3
  backbase-pods-retail3
]

use_frameworks!

def theme
  pod 'Theme', :path => 'Theme'
end

target 'FastMobile' do
  theme
  
  pod 'TCBService', '1.0.2'
  pod 'TCBVinPartner', '1.0.0'
  pod 'TCBComponents', '1.0.0'
  
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '5'
  pod 'SnapKit', '5.0.0'

  target 'FastMobileTests' do
  end

  target 'FastMobileUITests' do
  end

end
