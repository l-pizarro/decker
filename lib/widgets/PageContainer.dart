import 'package:flutter/material.dart';
import 'package:decker/theme.dart';

class PageContainer extends StatefulWidget {
  final Size size;
  final int selectedPage;
  final List<Widget> pages;

  PageContainer({
    this.size,
    this.pages,
    this.selectedPage,
  });

  @override
  _PageContainerState createState() => new _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.gray[600],
      width: widget.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: widget.pages[widget.selectedPage],
      )
    );
  }
}