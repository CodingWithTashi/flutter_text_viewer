import 'dart:io' if (dart.library.html) 'package:flutter_text_viewer/web.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_viewer/model/text_viewer.dart';
import 'package:flutter_text_viewer/widget/text_content.dart';
import 'package:flutter_text_viewer/widget/textviewer_search_appbar.dart';

class TextViewerPage extends StatefulWidget {
  ///Generic model of text viewer with field
  final TextViewer textViewer;

  ///Boolean flag to show search appbar or not
  final bool showSearchAppBar;

  ///leading icon
  final Widget? leading;
  const TextViewerPage({
    Key? key,
    required this.textViewer,
    this.showSearchAppBar = false,
    this.leading,
  }) : super(key: key);

  @override
  State<TextViewerPage> createState() => _TextViewerPageState();
}

class _TextViewerPageState extends State<TextViewerPage> {
  ///String content of the file
  String content = '';

  ///Total length of the content in terms of characters
  int contentCharacterLength = 0;

  ///Initial Character index set to 0
  int initialIndex = 0;

  ///Character limit for each view, default it is set to 300000
  int characterLimit = 300000;

  ///Total Count of the result word or string
  int searchResultCount = 0;

  ///Search text field controller
  String searchValue = '';

  ///Scroll controller while navigating from one search word to another word
  late ScrollController scrollController;

  ///Keys list to store the found value
  final List<GlobalKey> _keys = [];

  ///Index of the found value, Initially set it to zero
  int _focusKeyIndex = 0;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showSearchAppBar ? _getSearchAppBar() : null,
      body: SafeArea(
        child: FutureBuilder<String>(
          future: _getContentFromPath(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (searchValue.isNotEmpty) ...[
                    _getSearchResultCount(),
                  ],
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: TextContent(
                        text: snapshot.data!,
                        highlightText:
                            searchValue.isNotEmpty ? searchValue : null,
                        highlightColor: widget.textViewer.highLightColor,
                        focusColor: widget.textViewer.highLightColor,
                        ignoreCase: widget.textViewer.ignoreCase,
                        highlightStyle: widget.textViewer.highLightTextStyle,
                        focusStyle: widget.textViewer.focusTextStyle,
                        keys: _keys,
                        focusKeyIndex: _focusKeyIndex,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //_getPreviousPage(),
                      _getPreviousSearch(),
                      _getNextSearch(),
                      //_getNextPage(),
                    ],
                  )
                ],
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  _getSearchAppBar() => SearchAppBar(
        leading: widget.leading,
        searchCallBack: (String value) {
          if (value.isNotEmpty) {
            setState(() {
              searchValue = value;
            });
          } else {
            if (widget.textViewer.onErrorCallback != null) {
              widget.textViewer.onErrorCallback!('Enter some value to search');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Enter some value to search'),
              ));
            }
          }
        },
      );

  Future<String> _getContentFromPath() async {
    ///set content to empty before value was set
    content = "";

    ///Set content character count to 0 initially
    contentCharacterLength = 0;
    try {
      ///if TextViewer.asset is used, check if asset path is null or not
      ///same goes for TextViewer.file is null or not
      if (widget.textViewer.assetPath != null) {
        content = await rootBundle.loadString(widget.textViewer.assetPath!);
      } else if (widget.textViewer.filePath != null) {
        final File file = File(widget.textViewer.filePath!);
        content = file.readAsStringSync();
      } else {
        content = widget.textViewer.textContent ?? '';
      }

      ///If search text is not empty then get the count of search found text
      if (searchValue.isNotEmpty) {
        if (widget.textViewer.ignoreCase) {
          searchResultCount =
              content.toLowerCase().split(searchValue.toLowerCase()).length - 1;
        } else {
          searchResultCount = content.split(searchValue).length - 1;
        }
      }
      contentCharacterLength = content.length;
      if (contentCharacterLength > characterLimit) {
        content =
            content.substring(initialIndex, initialIndex + characterLimit);
      }
    } catch (e) {
      rethrow;
    }

    return content;
  }

  ///Show previous button only if it is second page or after
  /*_getPreviousPage() {
    return initialIndex != 0
        ? IconButton(
            onPressed: () {
              setState(() {
                scrollController.jumpTo(0);
                initialIndex -= characterLimit;
              });
            },
            icon: const Icon(Icons.skip_previous),
          )
        : const SizedBox();
  }

  _getNextPage() {
    return IconButton(
      onPressed: () {
        scrollController.jumpTo(0);
        setState(() {
          initialIndex += characterLimit;
        });
      },
      icon: const Icon(Icons.skip_next),
    );
  }*/

  Widget _getPreviousSearch() {
    ///Show fast_rewind icon if search field is not empty, found key list is not empty
    ///and focus key index is not 0
    if (searchValue.isNotEmpty && _keys.isNotEmpty && _focusKeyIndex != 0) {
      return IconButton(
        onPressed: () {
          if (_focusKeyIndex > 0) {
            setState(() {
              _focusKeyIndex--;
              Scrollable.ensureVisible(
                _keys[_focusKeyIndex].currentContext!,
                alignment: 0.2,
                duration: const Duration(milliseconds: 300),
              );
            });
          }
        },
        icon: const Icon(
          Icons.fast_rewind,
        ),
      );
    }
    return const SizedBox();
  }

  Widget _getNextSearch() {
    ///Show fast_forward icon if search field is not empty, found key list is not empty
    ///and focus key index is less then total length-1
    if (searchValue.isNotEmpty &&
        _keys.isNotEmpty &&
        _focusKeyIndex < _keys.length - 1) {
      return IconButton(
        onPressed: () {
          if (_focusKeyIndex < _keys.length - 1) {
            setState(() {
              _focusKeyIndex++;
              Scrollable.ensureVisible(
                _keys[_focusKeyIndex].currentContext!,
                alignment: 0.2,
                duration: const Duration(milliseconds: 300),
              );
            });
          }
        },
        icon: const Icon(
          Icons.fast_forward,
        ),
      );
    }
    return const SizedBox();
  }

  _getSearchResultCount() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search Result : $searchResultCount',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Current Status : ${_focusKeyIndex + 1}/$searchResultCount',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
