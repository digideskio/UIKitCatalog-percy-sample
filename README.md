This project demonstrates the use of percy.io on apple sample code application UIKitCatalog.

Steps for adding percy tests:

1. add a new iOS UI Testing target (swift) ![Add iOS UI Testing](/step_images/add_target.png)
2. download and add XCTestCase+percySnapshot.swift to the UI Testing target. You can get the code from: [percy-ios-uitest-helpers](https://github.com/mfazekas/percy-ios-uitest-helpers)
3. write/record UI Test and add percyScreenshot calls (we recommend starting with smaller number of screenshots and extending later)
4. add Gemfile and percy.rb from [percy-ios](https://github.com/mfazekas/percy-ios)
   Gemfile:
   ```ruby
   source 'https://rubygems.org'

   gem 'percy-ios', github: 'mfazekas/percy-ios'
   ```

   percy.rb
   ```ruby
   require 'percy/ios'
   raise 'please pass derived-data as first argument' if ARGV[0].nil?
   percy = Percy::IOS.new
   percy.derived_data_dir=ARGV[0]
   percy.upload_screenshots
   ```
5. run ```bundle install``` (if you don't have bundler installer you need to execute ```gem install bundler``` before)
6. register to percy.io and make note of your write only api key.
7. run 'xcodebuild' and percy locally make sure you specify derevedDataPath to xcodebuild. You can run your tests on multiple devices.

   ```sh
   rm -rf ./derived-data ; xcodebuild test -scheme UIKitCatalog -onlyTesting:UIKitCatalogPercyTests -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 5,OS=10.1' -destination 'platform=iOS Simulator,name=iPad Air,OS=10.1' -derivedDataPath ./derived-data
   PERCY_TOKEN=*** PERCY_PROJECT=mfazekas/UIKitCatalog-percy-sample PERCY_BRANCH=master bundle exec ruby ./percy.rb ./derived-data
   ```

8. Add travis.yml file and configure PERCY_TOKEN and PERCY_PROJECT in travis, and make sure your shceme is set to shared and autocreate:

   ```yml
   language: objective-c
   os: osx
   osx_image: xcode8
   script:
     - xcodebuild test -scheme UIKitCatalog -only-testing:UIKitCatalogPercyTests -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 5,OS=10.0' -destination 'platform=iOS Simulator,name=iPad Air,OS=10.0' -derivedDataPath ./derived-data
     - bundle exec ruby ./percy.rb ./derived-data
   ```

   ![Travis config](/step_images/travis_settings.png)

   ![XCode scheme sharing](/step_images/xcode_scheme.png)

## Discailmer

The is based on [UIKitCatalog](https://developer.apple.com/library/content/samplecode/UICatalog/) sample code from Apple. See LICENSE_original and README_original for information on the sample code itself.

