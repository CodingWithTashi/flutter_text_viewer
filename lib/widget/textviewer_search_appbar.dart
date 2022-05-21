import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Function(String value) searchCallBack;
  const SearchAppBar({Key? key, this.leading, required this.searchCallBack})
      : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        leading: widget.leading,
        title: TextField(
          controller: searchController,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
              //prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => widget.searchCallBack(searchController.text),
          ),
        ]);
  }
}
