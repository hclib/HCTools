
Pod::Spec.new do |s|

  s.name         = "HCTools"
  s.version      = "1.0.0"
  s.summary      = "Some sample useful tools!"
  s.homepage     = "https://github.com/woshishc/HCTools"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "suhc" => "hongchengplus@163.com" }
  s.platform     = :ios
  # s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/woshishc/HCTools.git", :tag => "1.0.0" }
  s.source_files  = "HCTools", "HCTools/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"
  s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  s.requires_arc = true
  # s.dependency "JSONKit", "~> 1.4"

end
