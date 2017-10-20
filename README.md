![Tart](./Resources/tart-banner-path.svg)

#### A smart dependency manager built on top of Cmake

# The Tart Build System
## What can I do with Tart?

Tart is a dependency management system that is written as a collection of CMake tools. 

Main features:
* Automatic dependency management based on git tags
* Simple library configuration  in a tart.yaml file
* Total interoperability with regular CMake
* Supports nested dependencies

## How can I install Tart?

To be able to use Tart you need to:
* Install Git
* Install Cmake
* Clone this repo
* Include the line  `INCLUDE("<path-to-Tart>/Modules/tart-include.cmake")` in your CMakeLists file to add it to your cmake file.


## How do I add a dependency to my Target using Tart?

To add a library `ExampleLib` to your target, Tart allows you to do so by simply add following line in in your CMakeLists.txt:

```
ADD_DEPENDENCY("ExampleLib" "ExampleApp")
```
It will first Look for any existing git repo in the same folder as the current CMakeLists.txt parent folder is located. If it doesn't find any, it will clone it from its defined git repo URL.

## Library settings

The Flags and structure of the libraries controlled with tart should include a file called `tart.yaml` that describes the library.


## Example

An example can be found in the ExampleWorkspace, consisting of an Executable and 3 linked example libs.
