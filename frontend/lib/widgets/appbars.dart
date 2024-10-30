import 'package:flutter/material.dart';

class appBarTop extends StatefulWidget implements PreferredSizeWidget {
  const appBarTop({super.key});

  @override
  State<appBarTop> createState() => _appBarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _appBarTopState extends State<appBarTop> {
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



class appBarBottom extends StatefulWidget {
  const appBarBottom({super.key});

  @override
  State<appBarBottom> createState() => _appBarBottomState();
}

class _appBarBottomState extends State<appBarBottom> {
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


