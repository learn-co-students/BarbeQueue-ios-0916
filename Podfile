# platform :ios, '7.0'
#
source 'https://github.com/CocoaPods/Specs.git'

pod 'Reachability'
pod 'OHHTTPStubs'
# Add Application pods here

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Specta', :git => 'git@github.com:specta/specta.git'
  pod 'Expecta'
  pod 'OCMockito'
  pod 'Swizzlean'
  pod 'KIF'
end
