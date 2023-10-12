import 'package:flutter/material.dart';
import 'package:twitter_clone/custom/refresh2.dart';
import 'package:twitter_clone/model/trend_topic.dart';

class SearchView extends StatefulWidget {
  const SearchView(this.scrollController);

  final ScrollController scrollController;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  double _padding = 20;
  late TrendTopic _topic;
  bool isRefresh = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _topic = TrendTopic(hashtag: "#Champions League", location: "Trending in Turkey", tweets: "16.8K Tweets");
  }

  Future<void> tempFuture() async {
    setState(() {
      isRefresh = !isRefresh;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isRefresh = !isRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: Refreshv2(
        onRefresh: tempFuture,
        child: ListView(
          controller: widget.scrollController,
          children: [
            _downIconWidget,
            _emptySpace,
            _trendTitleWidget,
            _listHashView,
          ],
        ),
      ),
    );
  }

  Widget get _downIconWidget => AnimatedContainer(
      height: isRefresh ? 60 : 30,
      duration: Duration(milliseconds: 400),
      child: isRefresh
          ? Center(child: CircularProgressIndicator())
          : const Icon(Icons.arrow_downward, color: Colors.grey));

  Widget get _emptySpace => const SizedBox(height: 10);

  Widget get _trendTitleWidget => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: const EdgeInsets.all(0),
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey, width: 0.5), borderRadius: BorderRadius.circular(0)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          height: 50,
          alignment: Alignment.centerLeft,
          child: Text(
            'Trends for you',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );

  Widget get _divider => const Divider(
        height: 0,
        color: Colors.grey,
      );

  Widget get _listHashView => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return cardListMethod(context);
      },
      separatorBuilder: (context, index) {
        return _divider;
      },
      itemCount: 10);

  Card cardListMethod(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: const RoundedRectangleBorder(side: BorderSide(style: BorderStyle.none)),
        child: listPadding(context));
  }

  Padding listPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 5),
      child: row(context),
    );
  }

  Row row(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            direction: Axis.vertical,
            spacing: 5,
            children: [
              Text(_topic.location ?? '', style: Theme.of(context).textTheme.bodySmall),
              Text(_topic.hashtag ?? '', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 15)),
              Text(
                _topic.tweets ?? '',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_drop_down),
      ],
    );
  }
}
