#
# Be sure to run `pod lib lint FearthGdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'FearthGdk'
  s.version = '0.5.0'
  s.summary = 'Fearth Game Development Kit'
  s.description = 'Includes needed functions for a game on iOS'
  s.homepage = 'https://github.com/phucanh1939/fearth-ios-gdk'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'phucanh' => 'phucanh1939@gmail.com' }
  # s.source = { :http => "https://github.com/phucanh1939/fearth-ios-gdk/releases/download/v#{s.version}/#{s.name}-v#{s.version}.zip" }
  # s.vendored_frameworks = "**/FearthGdk.framework"
  s.source = { :git => 'https://github.com/phucanh1939/fearth-ios-gdk.git', :tag => "v#{s.version}" }
  s.source_files = 'src/**/*.{h,m,mm}', 'include/**/*.{h,m,mm}'
  s.public_header_files  = 'include/**/*.h'
  s.requires_arc = true
  s.ios.deployment_target = '12.0'
  s.frameworks = 'UIKit', 'SafariServices'
  # Dependencies
  s.dependency 'TrustWalletCore'
  # s.dependency 'JSONModel'  # JSON parsing library for Objective-C
end
