# SwiftModuleSample
A sample Xcode workspace to develop Swift executable targets that link against pure Swift modules.

## Disclaimer

This might be out of date and unnecessary. `swift build` and `swift package generate-xcodeproj` go a long way these days.

## Intention

Create a simple project configuration to enable developing a module in parallel with other targets. Everything in Swift.

## Setup Summary
* Library project
 * Add a command line target to enable adding any linked frameworks in Build Phases.  This is only for development purposes.
 * Add all exportable classes to a `src` directory
* Executable project
 * Add a `lib` directory that will contain the .a, .swiftdoc, and .swiftmodule files. Add a Swift compiler import path to this directory.
 * Add a `Run Script` build phase before compilation that contains the contents of `build.sh`
 * Add artifacts of the script to the project and ensure the link phase links to the .a file
