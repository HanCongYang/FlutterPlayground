import 'package:flutter/material.dart';
import '../constrant.dart' show Constants;
import './conversion_page.dart';

enum ActionItems {
  GROUP_CHAT,
  ADD_FRIEND,
  QS_SCAN,
  PAYMENT,
  HELP
}

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, IconData icon, IconData activeIcon}) :
    _title = title,
    _icon = icon,
    _activeIcon = activeIcon,
    item = new BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      title: Text(title),
      backgroundColor: Colors.white
    );
}

class HomeScreen extends StatefulWidget {

_HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

PageController _pageController;

int _currentIndex = 0;

List<NavigationIconView> _navigationViews;
List<Widget> _pages;

void initState() {
  super.initState();
  _navigationViews = [
    NavigationIconView(
      title: '微信',
      icon: IconData(
        0x3608,
        fontFamily: Constants.IconFontFamily,
      ),
      activeIcon: IconData(
        0x3608,
        fontFamily: Constants.IconFontFamily,
      ),
    ),
        NavigationIconView(
      title: '通讯录',
      icon: Icons.ac_unit,
      activeIcon: Icons.access_alarm,
    ),
        NavigationIconView(
      title: '发现',
      icon: Icons.ac_unit,
      activeIcon: Icons.access_alarm,
    ),
        NavigationIconView(
      title: '我',
      icon: Icons.ac_unit,
      activeIcon: Icons.access_alarm,
    ),

  ];

  _pageController = PageController(initialPage: _currentIndex);

  _pages = [
    ConversationPage(),
    Container(color:  Colors.green),
    Container(color:  Colors.blue),
    Container(color:  Colors.pink),
  ];
}

_buildPopupMenuItem(int iconName, String title) {

  return Row(
    children: <Widget>[
      Icon(IconData(
        iconName,
        fontFamily: Constants.IconFontFamily
      )),
      Container(width: 16.0),
      Text(title),
    ],
  );
}

  @override
  Widget build(BuildContext content) {



    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      fixedColor: Colors.pink,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {

        setState(() {
            _currentIndex = index;

            _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
        print('点击的是第$index个Tab');
      },
    );
    return Scaffold(

      appBar: AppBar(
        // backgroundColor: Color(0xff303030),
        title: Text('微信'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Mother Fucker');
            },
          ),
          PopupMenuButton(
            onSelected: (ActionItems selected) {
              print("点击的是$selected");
            },
            itemBuilder: (BuildContext content) {

              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "发起群聊"),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "扫一扫"),
                  value: ActionItems.QS_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "首付款"),
                  value: ActionItems.PAYMENT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, "帮助与反馈"),
                  value: ActionItems.HELP,
                ),
              ];
            },

          )

        ],
      ),

      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          print(index);
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          print('$index');
          setState(() {
                      _currentIndex = index;
                    });
        },
      ),

      bottomNavigationBar: botNavBar,
    );
  }
}