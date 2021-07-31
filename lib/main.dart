import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_json_example/offices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<OfficesList> officesList;
  @override
  void initState() {
    super.initState();
    // loadData();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual JSON Serialization'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data!.offices[index].name}'),
                      subtitle:
                          Text('${snapshot.data!.offices[index].address}'),
                      leading: Image.network(
                          '${snapshot.data!.offices[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Future<http.Response> getData() async {
//   const url1 = 'https://about.google/static/data/locations.json';
//   Uri url = Uri.parse(url1);
//   return await http.get(url);
// }

// void loadData() {
//   getData().then((response) {
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print(response.statusCode);
//     }
//   }).catchError((error) {
//     debugPrint(error);
//   });
// }
