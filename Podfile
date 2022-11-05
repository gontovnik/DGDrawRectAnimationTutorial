# Uncomment this line to define a global platform for your project
platform :ios, '14.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'DGDrawRectAnimationTutorial' do

pod 'pop', '~> 1.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            # update deployment target
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
    end
end
