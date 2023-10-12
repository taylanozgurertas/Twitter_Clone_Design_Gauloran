import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/home/home_view.dart';
import 'package:twitter_clone/home/search_view.dart';

class TwitterTabbarView extends StatefulWidget {
  const TwitterTabbarView({super.key});

  @override
  State<TwitterTabbarView> createState() => _TwitterTabbarViewState();
}

class _TwitterTabbarViewState extends State<TwitterTabbarView> {
  bool isHeaderClose = false;
  final String _githubPhotoUrl = 'https://avatars.githubusercontent.com/u/92798120?v=4';
  late ScrollController scrollController;
  double lastOffSet = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController.offset >= scrollController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController.offset > lastOffSet ? true : false;
      }
      setState(() {
        lastOffSet = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: SafeArea(
          child: Scaffold(
            /*
            floatingActionButton: _fabButton,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
             */
            bottomNavigationBar: _bottomAppBar,
            body: Column(
              children: [
                _containerAppbar,
                Expanded(
                    child: TabBarView(children: [
                  HomeView(scrollController),
                  SearchView(scrollController),
                  const Text('data'),
                  const Text('data'),
                ])),
              ],
            ),
          ),
        ));
  }

  Widget get _appBar => AppBar(
        elevation: 0,
        title: _appBarItems,
        centerTitle: false,
      );

  Widget get _appBarItems => Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_githubPhotoUrl),
          ),
          _emptyWidth,
          Expanded(child: _centerAppBarWidget),
          _emptyWidth,
          const Icon(Icons.add_location_alt_rounded, color: Colors.black)
        ],
      );

  Widget get _emptyWidth => const SizedBox(
        width: 20,
      );

  Widget get _searchTextField => SizedBox(
        height: 40,
        child: TextField(
            decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: _searchTextFieldBorder,
          hintText: "Search",
          filled: true,
          /*
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(25)),
           */
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        )),
      );

  OutlineInputBorder get _searchTextFieldBorder =>
      OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(50));

  Widget get _centerAppBarWidget => currentIndex == 1 ? _searchTextField : const Text('Home', style: titleTextStyle);

  Widget get _containerAppbar => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: isHeaderClose ? 0 : 50,
        child: _appBar,
      );

  Widget get _tabBarItems => TabBar(
        isScrollable: false,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        tabs: const [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.search)),
          Tab(icon: Icon(Icons.autorenew_sharp)),
          Tab(icon: Icon(Icons.safety_check_sharp)),
        ],
      );

  Widget get _bottomAppBar => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: _tabBarItems,
        //notchMargin: 10,
      );
}

const titleTextStyle = TextStyle(
  letterSpacing: 1,
  fontSize: 20,
  fontWeight: FontWeight.w800,
  color: Colors.black,
);
