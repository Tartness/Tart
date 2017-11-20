![Tart](./Resources/tart-banner-path.svg)

#### The smart dependency manager built on top of CMake

# The Tart Build System
## What is Tart?

Tart is a dependency management system that with to main pillars:

1. The **tart.yaml** configuration standard. A `tart.yaml` file contains all parameter to describe a Tart Package, i.e. a CMake-configurable library. It also includes information about dependency of other tart packages.
2. A CMake toolchain that allows to read and configure a package from its `tart.yaml` file. It could theoretically be written in another language. As Tart heavily relies on CMake functionalities, the toolchain is written as CMake scripts for now.

Main features:
* Automatic dependency management based on git tags
* Simple library configuration in a `tart.yaml` file
* Flexible and customisable through total interoperability with CMake
* Supports nested dependencies
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
It will first Look for any existing git repo in the same folder as the current CMakeLists.txt parent folder is located. If it doesn't find any, it will clone it from its defined git repo URL.

## Library settings

The Flags and structure of the libraries controlled with tart should include a file called `tart.yaml` that describes the library.

## Example

An example can be found in the ExampleWorkspace, consisting of an Executable and 3 linked example libs.
See how `ExampleWorkspace/ExampleApp/CMakeLists.txt` is configured. You can run it by calling `sh run.sh`.


### Credits

Copyright 2017 Tartness (Nicolas Degen / [@nidegen](github.com/nidegen))

Made with ❤️ in 🇨🇭
