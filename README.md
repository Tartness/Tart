# Tart
The Tart Build System

## What can I do with Tart?

To add a library `TestLib` to your target, Tart allows you to do so by simply add following line in in your CMakeLists.txt:

```
ADD_DEPENDENCY("ExampleLib" "ExampleApp")
```
For now, it assumes that all libraries are in the same folder (workspace)

## Library settings

The Flags and structure of the libraries controlled with tart should include a file called `kakefile.yaml` that describes the library.


## Example

An example can be found in the ExampleWorkspace, consisting of an Executable and 3 linked example libs.
