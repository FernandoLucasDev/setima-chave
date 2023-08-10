// import 'package:flutter/material.dart';
// import 'package:setimachave/pages/japamala.dart';
// import 'package:setimachave/pages/post_create.dart';
// import 'package:setimachave/pages/posts_list.dart';
// import 'package:setimachave/utils/colors.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;

//   var pages = [
//     PostsList(),
//     PostScreen(),
//     Japamala(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star_border_outlined),
//             label: 'Posts',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.drive_file_rename_outline),
//             label: 'Criar',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.circle_outlined),
//             label: 'Japamala',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:setimachave/pages/japamala.dart';
import 'package:setimachave/pages/post_create.dart';
import 'package:setimachave/pages/posts_list.dart';
import 'package:setimachave/pages/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Profile(),
          PostScreen(),
          Japamala(),
          Profile(),
        ],
      ),
    );
  }
}

