# BSAtomParser

BSAtomParser is an Atom parser written in Objective-C for iOS. This parser is specifically developed to parse atom feeds (NOT RSS feeds). While I've tried my best to support all elements detailed in [RFC 4287](http://http://tools.ietf.org/html/rfc4287) the parser does not fully implement the specification, especially not validation parts. My goal has been to create a parser that will chug through atom feeds doing its best at returning whatever is valid and disregard everything else. BSAtomParser also handles atom extensions. 

The project includes some sample-feeds used to test the parser. If you do use this library and find a problem, please provide the feed together with the error report or if you fork and fix it, please include a test case that prove the bug and that you fixed it.

## Features

- Parse atom feeds, [RFC 4287](http://http://tools.ietf.org/html/rfc4287)
- Supports extension elements
- Parse entries in "delegate mode" and reduce memory usage

## Demo

A sample application is included in the project. It fetches an Atom feed from huffingtonpost.com and display the entries in a table view. Tap an entry to see the content. The demo is pulling the feed synchronously which is not recomended for production!

## Install (iOS)

- Add this repo as a submodule to your project using 'git submodule add ...' (optional)
- Add the files in 'BSAtomParser' to your project.
- Include 'BSAtom.h' to use the features in BSAtomParser.