# Fearth IOS GDK

## Requirement
- Cmake: `brew install cmake`
- Cocoapods: `$ sudo gem install cocoapods`
- Github CLI: `brew install gh`

## Setup

### Login to access Github CLI

Run `gh auth login` to login to Github CLI

## Build

For debug build, run `./build.sh Debug`.

For release build, run `./build.sh Release` or just `./build.sh`

After build success, framework file can be found at `./build/FearthGdk.xcframework`

## Upload Release to Github

Make sure you build the framework before upload it to Github releases.

Run `./upload_release.sh <version_tag>` to create or upload xcframework to a release on Github

## Verify & Publish Pod

Make sure you create release tag before publish the pod (check the version in `podspec`)

Run `./publish_pod.sh` to verify and publish the pod to cocoapods.

After publishing the pod, you can find it here `https://cocoapods.org/pods/FearthGdk`
