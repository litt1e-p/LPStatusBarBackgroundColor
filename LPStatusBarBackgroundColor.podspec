Pod::Spec.new do |s|
  s.name             = "LPStatusBarBackgroundColor"
  s.version          = "1.0.1"
  s.summary          = "change UIStatusBar's backgroundColor."
  s.description      = <<-DESC
                       change UIStatusBar backgroundColor dynamically which made via runtime.
                       DESC
  s.homepage         = "https://github.com/litt1e-p/LPStatusBarBackgroundColor"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'MIT' }
  s.author           = { "litt1e-p" => "litt1e.p4ul@gmail.com" }
  s.source           = { :git => "https://github.com/litt1e-p/LPStatusBarBackgroundColor.git", :tag => '1.0.1' }
  # s.social_media_url = 'https://twitter.com/NAME'
  s.platform = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true
  s.source_files = 'LPStatusBarBackgroundColor/*'
  # s.resources = 'Assets'
  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'
end
