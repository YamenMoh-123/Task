import 'package:flutter/material.dart';
import '../styles/styles.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onMenuPressed() {
   // print("Button Pressed");
  }

  final List<String> items =["one", "two", "three"];

  var currentAmount = 6;
  String currentCategory = "Books";

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
            IconButton(icon: const Icon(Icons.search), onPressed: () {})
          ],
        ),
      )),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(10),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start, // Adjust alignment as needed
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentAmount++;
                  });
                },
                style: mainButtonStyle,
                child: const Text("data"),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("$currentAmount $currentCategory in List"),
                ),
              ),
              PopupMenuButton(
                onSelected: (String result) {
                  //print(result);
                },


                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "Books",
                    child: Text("Books"),
                  ),
                  const PopupMenuItem<String>(
                    value: "Movies",
                    child: Text("Movies"),
                  ),
                  const PopupMenuItem<String>(
                    value: "Music",
                    child: Text("Music"),
                  ),
                ],
                color: Colors.blue.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey.shade500, width: 2),
                ),
                child: ElevatedButton(
                  onPressed: null, // The PopupMenuButton handles the tap
                  style: mainButtonStyle,
                  child: const Text("data"),
                ),
              ),
            ],
          ),
          // Add more widgets here as children of the Column if needed
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Divider(
              color: Colors.grey.shade500,
              height: 20,
              thickness: 2,
            ),
          ),

          Expanded(
            child:(
                ListView.builder(itemCount: items.length,
                    itemBuilder: (context, index){
                  return CardItem(key: ValueKey(items[index]));
                })
            )
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }
}
