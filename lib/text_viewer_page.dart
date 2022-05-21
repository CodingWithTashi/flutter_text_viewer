import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_viewer/model/text_viewer.dart';
import 'package:flutter_text_viewer/text_content.dart';

class TextViewerPage extends StatefulWidget {
  ///Generic model of text viewer with field
  final TextViewer textViewer;

  ///Boolean flag to show search appbar or not
  final bool showSearchAppBar;
  const TextViewerPage({
    Key? key,
    required this.textViewer,
    required this.showSearchAppBar,
  }) : super(key: key);

  @override
  State<TextViewerPage> createState() => _TextViewerPageState();
}

class _TextViewerPageState extends State<TextViewerPage> {
  String content = '';
  int initialIndex = 0;
  int characterCountLimit = 100000;
  int searchResultCount = 0;
  late TextEditingController searchController;
  late ScrollController scrollController;
  final List<GlobalKey> _keys = [];
  int _focusKeyIndex = 0;

  @override
  void initState() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showSearchAppBar ? _getSearchAppBar() : null,
      body: FutureBuilder<String>(
        future: _getContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                if (searchController.text.isNotEmpty) ...[
                  _getSearchResultCount(),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: TextContent(
                      text: snapshot.data!,
                      highlightText: searchController.text.isNotEmpty
                          ? searchController.text.toLowerCase()
                          : null,
                      highlightColor: widget.textViewer.highLightColor,
                      focusColor: widget.textViewer.highLightColor,
                      ignoreCase: widget.textViewer.ignoreCase,
                      highlightStyle: widget.textViewer.highLightTextStyle,
                      focusStyle: widget.textViewer.focusTextStyle,
                      keys: _keys,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getPreviousPage(),
                    if (searchController.text.isNotEmpty) ...[
                      _getPreviousSearch(),
                      _getNextSearch(),
                    ],
                    _getNextPage(),
                  ],
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _getSearchAppBar() {
    return AppBar(
      title: TextField(
        controller: searchController,
        decoration: searchController.text.isNotEmpty
            ? InputDecoration(
                suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    searchController.text = '';
                  });
                },
                icon: const Icon(Icons.clear),
              ))
            : const InputDecoration(),
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  Future<String> _getContent() async {
    content = "";
    if (widget.textViewer.assetPath != null) {
      content = await rootBundle.loadString(widget.textViewer.assetPath!);
    } else if (widget.textViewer.filePath != null) {
      //get file path here
      //content =
    } else {
      content = widget.textViewer.textContent ?? '';
    }

    if (searchController.text.isNotEmpty) {
      searchResultCount = content
              .toLowerCase()
              .split(searchController.text.toLowerCase())
              .length -
          1;
    }
    if (content.length > characterCountLimit) {
      content =
          content.substring(initialIndex, initialIndex + characterCountLimit);
    }

    return content;
  }

  _getPreviousPage() {
    return initialIndex != 0
        ? IconButton(
            onPressed: () {
              setState(() {
                scrollController.jumpTo(0);
                initialIndex -= characterCountLimit;
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
          initialIndex += characterCountLimit;
        });
      },
      icon: const Icon(Icons.skip_next),
    );
  }

  _getPreviousSearch() {
    return IconButton(
      onPressed: () {
        if (_focusKeyIndex > 0) {
          _focusKeyIndex--;
          Scrollable.ensureVisible(
            _keys[_focusKeyIndex].currentContext!,
            alignment: 0.2,
            duration: const Duration(milliseconds: 300),
          );
        }
      },
      icon: const Icon(
        Icons.fast_rewind,
      ),
    );
  }

  _getNextSearch() {
    return IconButton(
      onPressed: () {
        if (_focusKeyIndex < _keys.length - 1) {
          _focusKeyIndex++;
          Scrollable.ensureVisible(
            _keys[_focusKeyIndex].currentContext!,
            alignment: 0.2,
            duration: const Duration(milliseconds: 300),
          );
        }
      },
      icon: const Icon(
        Icons.fast_forward,
      ),
    );
  }

  _getSearchResultCount() {
    return Text('Search Result: $searchResultCount');
  }
}
