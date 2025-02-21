import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'weather_app', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  String _search = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _click() {
    setState(() {
      _search = _searchController.text;
      _searchController.text = "";
    });
  }

  TextField _title() => TextField(
    controller: _searchController,
    onSubmitted: (_) => _click(),
    decoration: const InputDecoration(
      icon: Icon(Icons.search, color: Colors.white54),
      hintText: 'Search location...',
      hintStyle: TextStyle(color: Colors.white38, fontStyle: FontStyle.italic),
      border: InputBorder.none,
    ),
    style: const TextStyle(color: Colors.white),
  );

  List<Widget> _actions() => [
    Container(width: 2, height: 35, color: Colors.white),
    IconButton(
      icon: const Icon(Icons.send, color: Colors.white),
      onPressed: () => _click(),
    ),
  ];

  BottomAppBar _bottomAppBar() => BottomAppBar(
    child: TabBar(
      controller: _tabController,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(icon: Icon(Icons.settings), text: "Currently"),
        Tab(icon: Icon(Icons.today), text: "Today"),
        Tab(icon: Icon(Icons.calendar_view_week), text: "Weekly"),
      ],
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
    ),
  );

  Widget _page(final String text) => Center(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            _search,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 91, 93, 114),
        title: width < 60 ? null : _title(),
        actions: width < 60 ? null : _actions(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_page('Currently'), _page('Today'), _page('Weekly')],
      ),
      bottomNavigationBar: height <= 75 ? null : _bottomAppBar(),
    );
  }
}
