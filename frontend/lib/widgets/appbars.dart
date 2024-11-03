import 'package:flutter/material.dart';

class AppBarTop extends StatefulWidget implements PreferredSizeWidget {
  const AppBarTop({super.key});

  @override
  State<AppBarTop> createState() => _AppBarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarTopState extends State<AppBarTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: onMenuPressed,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {


                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onMenuPressed() {
    //('Menu pressed');
  }
}



class AppBarBottom extends StatefulWidget {
  const AppBarBottom({super.key});

  @override
  State<AppBarBottom> createState() => _AppBarBottomState();
}

class _AppBarBottomState extends State<AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_box),
            onPressed: () {},
          ),
        ],
      ),

    );
  }
}


