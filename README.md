# HCTools(CocoaPods集成方法)

## 首先要确保你的电脑安装了cocoaPods<br>
1.$ gem install cocoapods<br>

## 2.为了把HCTools集成到你的项目中,你的Podfile要进行如下设定:<br>
platform :ios, '8.0'<br>

target 'TargetName' do<br>
pod 'HCTools',<br>
end<br>

## 3.然后在终端运行如下命令<br>
$ pod install
