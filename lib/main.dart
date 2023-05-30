import 'package:flutter/material.dart';
import 'package:linkedin/network.dart';

void main() {
  print(Uri.base);
  print(Uri.base.queryParameters['code']);
  Network.value = Uri.base.queryParameters['code'];
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FirstWidget(),
    );
  }
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (builder) => AlertDialog(
              content: Container(
                color: Colors.white,
                // height: 100,
                // width: 100,
                child: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Loading...'),
                  ],
                ),
              ),
            ),
          );
          await Network.signinWithLinkedIn()
              .then((value) => Navigator.pop(context));
        },
        child: Icon(
          Icons.login,
        ),
      ),
      body: (Network.value != null)
          ? FutureBuilder<String>(
              future: futureFunction(),
              builder: (builder, snapshot) {
                print("snapshot is $snapshot");
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        Network.value ?? 'data',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        Uri.base.toString(),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              })
          : Center(
              child: Text('Hello World'),
            ),
    );
  }

  Future<String> futureFunction() async {
    print("entered into future function with ${Network.value}");
    var linkedinAuthCode = await Network.getLinkedinAuthCode(
      Network.value ??
          'AQRYgdGv1UL5oy0Qzqg-SWf7tZOzTGiDf_-RlWGAQ7UuI42LnDSi4iLK02O3_y847vPG8CAQz2HIoloCflsiXiWNW3D6vdiOmK4OXsiaAW2AJn3uyNjjEElPkSnIph6fnh6xsfCnA4Ezd0cgrJOHXZ4VrugHHk49xmoiXUjzBUZDWUWRCsXxxd44Ao_O26IPgvexxwoOhdQ2zaMDxz8',
    );
    Network.value = linkedinAuthCode;
    print(
        "the linked in auth code is $linkedinAuthCode and network value is  ${Network.value} equal to network.value ${linkedinAuthCode == Network.value}");

    var userResponse = await Network.readLinkedinUser();
    print('The user response is $userResponse');
    return 'null';
  }
}
