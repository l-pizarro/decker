import 'package:flutter/material.dart';
import 'package:decker/theme.dart';

class PageContainer extends StatefulWidget {
  final Size size;
  final int selectedPage;

  PageContainer({
    this.size,
    this.selectedPage
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
    List<Widget> pages = [
      Column(children: <Widget>[Text("0")]),
      Column(children: <Widget>[Text("1")]),
      Column(children: <Widget>[Text("2")]),
      Column(children: <Widget>[Text("3")]),
      Column(children: <Widget>[Text("4")]),
    ];
    return Container(
      color: ThemeColors.gray[600],
      width: widget.size.width,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: pages[widget.selectedPage],
        )
      )
    );
  }
}