
Pod::Spec.new do |s|

  s.name         = "YJHomeKit"
  s.version      = "0.0.3"
  s.summary      = "YJHomeKit 自己用的"
  s.description  = "用CocoaPods做iOS程序的依赖管理，测试"
  
  #s.description  = <<-DESC
  #用CocoaPods做iOS程序的依赖管理，测试
  #DESC

  s.homepage     = "https://github.com/qq756585379/YJHomeKit"
  s.screenshots  = "http://media.yangjunv5.top/wexin_receive.jpg", "http://media.yangjunv5.top/wexin_receive2.png"

  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "杨俊" => "756585379@qq.com" }
  # Or just: s.author    = "杨俊"
  # s.authors            = { "杨俊" => "756585379@qq.com" }
  # s.social_media_url   = "http://twitter.com/杨俊"

  s.platform     = :ios, "9.0"

  #  When using multiple platforms
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/qq756585379/YJHomeKit.git", :tag => "#{s.version}" }

  # s.exclude_files = "Classes/Exclude"

  s.public_header_files = 'YJHomeKit/*.{h}' , 'YJHomeKit/**/*.{h}'

  s.source_files = 'YJHomeKit/*.{h,m}' , 'YJHomeKit/**/*.{h,m}'

  s.resource = "YJHomeKit/**/*.bundle"

  # s.subspec 'Core' do |ss|
  #   ss.source_files = 'YJHomeKit/Core/*.{h,m}'
  #   ss.public_header_files = 'YJHomeKit/Core/*.h'
  # end

  # s.subspec 'UIKit' do |ss|
  #   ss.ios.deployment_target = '9.0'
  #   ss.dependency 'YJHomeKit/Core'
  #   ss.source_files = 'YJHomeKit/UIKit/*.{h,m}'
  #   ss.public_header_files = 'YJHomeKit/UIKit/*.h'
  # end

  # s.subspec 'Category' do |ss|
  #   ss.ios.deployment_target = '9.0'
  #   ss.source_files = 'Category/**/*.{h,m}'
  #   ss.public_header_files = 'Category/**/*.h'

  #   # ss.subspec 'UIView' do |sss|
  #   #   sss.source_files = 'YJHomeKit/Category/**/*.{h,m}'
  #   #   sss.public_header_files = 'YJHomeKit/Category/**/*.h'
  #   # end
  # end

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "UIKit"
  s.frameworks = "UIKit", "Foundation"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Masonry"
  s.dependency "PureLayout"
  s.dependency "ReactiveObjC"
  s.dependency "MBProgressHUD"
  s.dependency "AFNetworking"
  
  
end
