![Tart](./Resources/tart-banner-path.svg)

#### The smart dependency manager built on top of CMake

# The Tart Build System
## What is Tart?

Tart is a dependency management system that with to main pillars:

1. A very simple package configuration file **tart.yaml**. A `tart.yaml` file contains all parameter to describe a Tart package such as:
 - Dependencies of other Tart packages
 - Platform specific (CMake) properties
 - Other package details and settings

  An example:

  ```
  dependency:
    - ExampleLibC
    - ExampleLibD
      - host: github 
      - publisher: Tartness 
      - checkout: 3.0
  lib_name: ExampleLibB
  include_dir: include
  src_dir: src
  target_properties:
    - CXX_STANDARD 14
  target_compile_definitions:
    - MY_CONSTANT="12345"
  target_os_properties:
    - macOS:
      - XCODE_FILE_ATTRIBUTES "Client,Server"
    - windows:
      - VS_DOTNET_REFERENCES_COPY_LOCAL TRUE
  target_arch_compile_definitions:
    - X64:
      - IS_X64
      - PI="3.1415926536f"
    - arm64:
      - USING_ARM="true"
      - PI="3.14159f"
  ```

2. Currently, a pure **CMake toolchain** that allows to :
  - Parse basic `.yaml` files
  - Clone git repos at specific branches/tags/commits
  - Build Logging
  - Standardized CMake target configuration 
  
  It could theoretically be written in another language. As Tart heavily relies on CMake functionalities, the toolchain is written as a collection of CMake scripts for now.

Some highlights of Tart:
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
