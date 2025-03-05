#
# Be sure to run `pod lib lint FearthGdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'FearthGdk'
  s.version               = '0.0.1'
  s.summary               = 'Fearth Game Development Kit'
  s.description           = 'Includes needed functions for a game on iOS'
  s.homepage              = 'https://github.com/phucanh1939/fearth-ios-gdk'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'phucanh' => 'phucanh1939@gmail.com' }
  s.source                = { :git => 'https://github.com/phucanh1939/fearth-ios-gdk.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files          = 'FearthGdk/Classes/**/*.{h,m,mm}', 'FearthGdk/Headers/**/*.{h,m,mm}'
  s.public_header_files   = 'FearthGdk/Headers/**/*.h'

  # s.frameworks          = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
