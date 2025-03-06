# Fearth IOS GDK

This is a general iOS GDK for mobile games on iOS.

## Requirement
- Cmake: `brew install cmake`
- Cocoapods: `$ sudo gem install cocoapods`
- Github CLI (for uploading Github release): `brew install gh`

## Build & Run Sample

Sample project is used to test the GDK implementation by directly pod to local pod.

To build and run the sample project:
- Install pods by running `cd ./sample & pod install`
- Open `./sample/fearth-ios-gdk-sample.xcworkspace` with Xcode
- Build and Run with Xcode

## Build GDK Framework

For debug build, run `./build.sh Debug`.

For release build, run `./build.sh Release` or just `./build.sh`

After build success, framework file can be found at `./build/FearthGdk.xcframework`

## Upload Release to Github

Make sure you build the framework before upload it to Github releases.

Run `gh auth login` to login to Github CLI

Run `./upload_release.sh <version_tag>` to create or upload xcframework to a release on Github

## Verify & Publish Pod

To publish pod to Cocoapods server, you need to register and authenticate with CocoaPods Trunk by running `pod trunk register your_email@example.com`

Make sure you create release tag before publish the pod (check the version in `podspec`)

Run `./publish_pod.sh` to verify and publish the pod to cocoapods.

After publishing the pod, you can find it here `https://cocoapods.org/pods/FearthGdk`

## Using FearthGdk in another project

You can use FeartGdk for iOS by adding pod to your Podfile. There are 2 way:
- Using git repo link.
- Using published pod on Cocoapods.

```ruby
# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'fearth-ios-gdk-sample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Using git repo
  pod 'FearthGdk', :git => 'https://github.com/phucanh1939/fearth-ios-gdk.git', :tag => 'v0.4.0'
  
  # Using published pod on cocoapods
  pod 'FearthGdk', '~> 0.4'
end
```
