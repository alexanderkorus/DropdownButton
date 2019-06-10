#
# Be sure to run `pod lib lint DropdownButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DropdownButton'
  s.version          = '0.1.1'
  s.summary          = 'A button which open a dropwdown with selectable elements.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A customizable button which open a dropwdown with selectable elements. Based on iOSDropDown Library by jriosdev.
                        DESC

  s.homepage         = 'https://github.com/alexanderkorus/DropdownButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexanderkorus' => 'alexander.korus@svote.io' }
  s.source           = { :git => 'https://github.com/alexanderkorus/DropdownButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'DropdownButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DropdownButton' => ['DropdownButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 5.0.0'
  s.swift_version = '4.2'

end
