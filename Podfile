# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Converter' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Converter
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire'
  pod 'DropDown', '2.3.2'
  pod 'SVProgressHUD'
  pod 'Actions', '~> 3.0.1'
  
  
  target 'ConverterTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'ConverterUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['DropDown'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.0'
        end
      end
    end
  end
  
end
