#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "LKTextExpander"
#  s.version          = File.read('VERSION')
  s.version          = "1.0.2"
  s.summary          = "A short description of LKTextExpander."
  s.description      = <<-DESC
                       An optional longer description of LKTextExpander

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "http://EXAMPLE/NAME"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Hiroshi Hashiguchi" => "xcatsan@mac.com" }
  s.source           = { :git => "http://github.com/lakesoft/LKTextExpander.git", :tag => s.version.to_s }
#  s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.dependency 'TextExpander', '~> 2.3'

 
end
