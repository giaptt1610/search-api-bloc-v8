import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search/search_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final _searchBloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 50.0,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          _searchBloc.add(GithubSearchEvent(value));
                        },
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    IconButton(
                        onPressed: () {
                          _controller.clear();
                        },
                        icon: Icon(Icons.clear)),
                  ],
                ),
              ),
              const Divider(height: 2.0),
              Expanded(
                child: BlocBuilder(
                  bloc: _searchBloc,
                  builder: (context, state) {
                    if (state is Searching) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SearchSuccess) {
                      final users = state.users;
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Image.network(users[index].avatar),
                            title: Text(users[index].username),
                          ),
                        ),
                      );
                    } else if (state is SearchFailed) {
                      return Center(
                        child: Text('error!'),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
