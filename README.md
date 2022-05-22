# flutter_text_viewer 

flutter_text_viewer is a simple text viewer package to load and search text from assets,file.   

## Demo
![Image](https://github.com/CodingWithTashi/flutter_text_viewer/blob/master/example/demo/search.png?raw=true)

## Features

* Load text from assets/file or string
* View text
* Search text

## Getting started

```dart
flutter_text_viewer: ^0.0.1

```   
Import the library:
```dart
import 'package:flutter_text_viewer/flutter_text_viewer.dart';

```
## Usage   

```dart
TextViewerPage(
   textViewer: TextViewer.asset(
      'assets/test.txt',
      highLightColor: Colors.yellow,
      focusColor: Colors.orange,
      ignoreCase: true,
      ),
   showSearchAppBar: true,
   )
```
If you have any questions, feedback or ideas, feel free to [create an
issue](https://github.com/CodingWithTashi/flutter_text_viewer/issues/new). If you enjoy this
project, I'd appreciate your [🌟 on GitHub](https://github.com/CodingWithTashi/flutter_text_viewer/).   

## You can also buy me a cup of coffee   
<a href="https://www.buymeacoffee.com/codingwithtashi"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width=200px></a>

