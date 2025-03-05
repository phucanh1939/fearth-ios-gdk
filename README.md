# Cocoapods Guide

## Setup the Pod Project

### Install CocoaPods (if not installed)
```sh
sudo gem install cocoapods
```

### Create a New Pod
```sh
pod lib create PodName
```
- Choose **Objective-C** as the language.
- This creates a folder structure for your pod and a `podspec` file to config the pod.

### Setup Source & Header Files

Source files and headers should follow a clear and modular structure to separate private and public components. Here's a recommended structure for organizing your source and header files:
- Source files and private headers will be stored in `PodName/Classes`
- Public headers will be stored in `PodName/Headers`

```graphql
PodName/
├── PodName.podspec
├── PodName/
│   ├── Classes/          # Implementation files (.m, .mm, .cpp)
│   │   ├── PodName.m     # Main implementation file
│   │   ├── Helper/
│   │   │   ├── PrivateHelper.h    # Private header (not exposed)
│   │   │   ├── PrivateHelper.m    # Private implementation
│   ├── Headers/          # Public headers (only this is exposed)
│   │   ├── FearthGdk.h   # Main public header
│   │   ├── Utilities.h   # Additional public API headers
│   │   ├── Models.h      # Public data structures
│   ├── Assets/           # Optional resources (images, JSON, etc.)
└── Example/              # Example project to test the pod
```

Update `source_files` and `public_header_files` in `.podspec` like that:
```ruby
  s.source_files          = 'FearthGdk/Classes/**/*.{h,m,mm}', 'FearthGdk/Headers/**/*.{h,m,mm}'
  s.public_header_files   = 'FearthGdk/Headers/**/*.h'
```

## Add Files to Pod project

- Add source files & private headers to `PodName/Classes`.
- Add public headers to `PodName/Headers`
- To update example project run `cd Example & pod update`

## Verify the Podspec (before publishing the pod)

Run:
```sh
pod lib lint --allow-warnings
```
- This checks if the pod can be integrated properly.
- It ensures that all public headers, source files, and dependencies are correct.
- Fix issues if pod lib lint fails before proceeding.

##