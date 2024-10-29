import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/item.dart';
import '../styles/styles.dart';
import 'card.dart';
import '../services/api_fetch.dart';
import '../services/api_crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> ListItems = [];

  @override
  void initState() {
    super.initState();
    loadDataAsync();
  }


  Future<void> loadDataAsync() async {
    try {
      List<Item> fetchedItems = await ApiFetch().fetchItems();
      setState(() {
        ListItems = fetchedItems;
      });
    } catch (e) {
      setState(() {
        ListItems =
        [Item(id: 1, title: 'Failed to load data', rating: 'N/A', author: 'N/A')];
      });
    }
  }

  void onMenuPressed() async {
    // print("Button Pressed");
  }


  final List<String> items = ["one", "two", "three"];

  var currentAmount = 6;
  String currentCategory = "Books";


  AppBar buildAppBar() {
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

        mainAxisAlignment: MainAxisAlignment.start,
        // Adjust alignment as needed
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


                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
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

          Card(
            child: ListTile(
              title: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                    ],
                  )
              ),
              onTap: () {
                handleItemAdd();
              },
            ),
          ),

          buildCards(),
        ],
      ),
    );
  }

  Widget buildCards() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: loadDataAsync,
          child:
            SlidableAutoCloseBehavior(

          child: ListView.builder(
          itemCount: ListItems.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      handleItemEdit(context, ListItems[index]);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      ApiCrud().deleteItem(ListItems[index].id);
                      setState(() {
                        ListItems.removeAt(index);
                      });
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: CardItem(
                key: ValueKey(ListItems[index].id),
                id: ListItems[index].id,
                title: ListItems[index]. title,
                rating: ListItems[index].rating,
                author: ListItems[index].author,
              ),
            );
          },
        ),

      ),
    ),
    );
  }




  void handleItemAdd() {

    Map<String, String> formData = {
      'title': '',
      'rating': '',
      'author': '',
    };
    
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Add Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                onChanged: (value) => formData['title'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Rating"),
                onChanged: (value) => formData['rating'] = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Author"),
                onChanged: (value) => formData['author'] = value,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                try {
                  Item newItem = await ApiCrud().addItem(formData);
                  setState(() {
                    ListItems.add(newItem);
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  // Handle errors or show an error message
                  print("Failed to add item: $e");
                }
              },
            )
          ],
        );
      },
    );
  }

  void handleItemEdit(BuildContext context, Item item) {
    Map<String, String> formData = {
      'title': item.title,
      'rating': item.rating,
      'author': item.author,
    };

    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                onChanged: (value) => formData['title'] = value,
                controller: TextEditingController(text: item.title),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Rating"),
                onChanged: (value) => formData['rating'] = value,
                controller: TextEditingController(text: item.rating),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Author"),
                onChanged: (value) => formData['author'] = value,
                controller: TextEditingController(text: item.author),
              ),
            ],
          ),
          actions: <Widget> [
            TextButton(
              child: const Text("Save"),
              onPressed: (){
                setState(() {
                  item.title = formData['title']!;
                  item.rating = formData['rating']!;
                  item.author = formData['author']!;
                });

                ApiCrud().editItem(item);
                Navigator.of(context).pop();
              },
            )
          ]
      );
    },
    );
    // navigate to edit page

  }

  BottomAppBar buildBottomAppBar() {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }
}
