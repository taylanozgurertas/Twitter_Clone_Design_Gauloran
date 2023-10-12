import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/home/tabbar_view.dart';

class HomeView extends StatefulWidget {
  const HomeView(this.controller, {super.key});

  final ScrollController controller;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String _randomProfilePic = 'https://resmim.net/cdn/2023/10/10/SUawtc.jpg';
  final String _dummyTweet =
      "I can't find any reason that Charles could win the fight against Oliveira because there is not.. really.";
  bool isHeaderClose = false;
  final String _ciriPhotoDummy = 'https://resmim.net/cdn/2023/10/12/SqYs8h.webp';

  int defaultTabLength = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: RefreshIndicator(
          onRefresh: () {
            return Future<void>.delayed(const Duration(milliseconds: 400));
          },
          child: _listView),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.adb),
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        controller: widget.controller,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
      child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(_randomProfilePic)),
          title: Wrap(
            runSpacing: 10,
            children: [
              _listCardTitle('Hello'),
              Text(_dummyTweet),
              _placeHolderField,
              _footerButtonList,
            ],
          )));

  Widget _listCardTitle(String text) => Text(text, style: titleTextStyle);

  Widget get _placeHolderField => Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Image.network(
          _ciriPhotoDummy,
        ),
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: [
          const Icon(Icons.comment, color: CupertinoColors.inactiveGray),
          Text(text),
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel("1"),
        onTap: () {},
      );

  Widget get _footerButtonList => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
        ],
      );
}
