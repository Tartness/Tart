![Tart](./Resources/tart-banner-path.svg)

# Tart ![Status](https://travis-ci.org/Tartness/Tart.svg?branch=master)

Tart is intended to be the simplest way to manage C/C++ dependencies.

Tart provides two features for dependency management:

1. A very simple package configuration file **tart.yaml**. A `tart.yaml` file contains all parameter to describe a Tart package such as:
 - Dependencies of other Tart packages
 - Platform specific (CMake) properties
 - Other package details and settings

1. A **CMake toolchain** that allows to:
  - Parse basic `.yaml` files to configure a package
  - Clone and checkout package dependencies at desired git tag/branch/commit

## Quick start
1. Get Tart by cloning this repo to your preferred location
1. In your CMakeLists.txt of choice, include following code after project definition: 
```
SET(TART_PATH "PATH_TO YOUR_LOCAL_TART_REPO")
INCLUDE("${TART_PATH}/Modules/tart-include.cmake")
```
1. Add Dependency to your desired CMake Target:

  ```
  ADD_TART_DEPENDENCY(YOUR_CMAKE_TARGET "TartPackageName")
  ```
  
1. Run cmake as usual.

### Some highlights of Tart:
* Automatic **dependency management** based on git tags
* Simple library configuration in a `tart.yaml` file
* Flexible and customisable through total **interoperability with CMake**
* Supports **nested dependencies**
* Support for Workspace-style folder structure

## How can I use Tart?

To be able to use Tart you need to:
* Install Git
* Install CMake
* Clone the Tart repo (this very repo here) 
* Include the line  `INCLUDE("<path-to-Tart-clone>/Modules/tart-include.cmake")` in your CMakeLists file to add it to your CMake file.

## How do I add a dependency to my Target using Tart?

To add a library `ExampleLib` to your target, Tart allows you to do so by simply add following line in in your CMakeLists.txt:
```
ADD_TART_DEPENDENCY("ExampleApp" "ExampleLib")
```
It will first Look for any existing git repo in the Tart workspace (which is usually assumed to be the parent folder of the root CMakeLists.txt file). If it doesn't find any, it will clone it from its defined git repo URL.

## What does a repo need to be a Tart Package?

The Flags and structure of the libraries controlled with tart should include a file called `tart.yaml` that describes the library.

## Example

An example can be found in the `ExampleWorkspace`, consisting of an Executable and 3 linked example libs.
See how `ExampleWorkspace/ExampleApp/CMakeLists.txt` is configured. You can run it by calling `sh run.sh`.

# Documentation

## Environment Variables

* `TART_TARGET_OS`: defaults to `UNDEF`
* `TART_TARGET_ARCH`: defaults to `UNDEF`
* `TART_CURRENT_WORKSPACE_DIR`: defaults to the parent directory of the root CMakeLists.txt file. Can be changed before any Tart functions are called.


### Credits

Copyright 2017 Tartness (Nicolas Degen / [@nidegen](github.com/nidegen))

Made with ❤️ in 🇨🇭
