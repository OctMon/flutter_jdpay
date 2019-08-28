#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_jdpay'
  s.version          = '0.0.1'
  s.summary          = '适用于商户App中集成京东支付功能'
  s.description      = <<-DESC
适用于商户App中集成京东支付功能
                       DESC
  s.homepage         = 'https://github.com/OctMon/flutter_jdpay'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'OctMon' => 'octmon@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.dependency 'Flutter'
  
  # 京东支付sdk
  s.dependency 'ALJDPay'
  # https://github.com/baiwhte/ALJDPay

  s.ios.deployment_target = '8.0'
end

