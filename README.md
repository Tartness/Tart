<h1>
    <p><img src= "./Resources/tart-logo.svg" class = "logo" style="vertical-align: top" alt = "Tart Logo" height="82" /> The Tart Build System</p>
</h1>

#### A smart cmake Toolchain


## What can I do with Tart?

To add a library `TestLib` to your target, Tart allows you to do so by simply add following line in in your CMakeLists.txt:

```
ADD_DEPENDENCY("ExampleLib" "ExampleApp")
```
For now, it assumes that all libraries are in the same folder (workspace)

## Library settings

The Flags and structure of the libraries controlled with tart should include a file called `tart.yaml` that describes the library.


## Example

An example can be found in the ExampleWorkspace, consisting of an Executable and 3 linked example libs.
