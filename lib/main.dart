import 'package:flutter/material.dart';

const _tgAvatar = 'assets/ava.jpeg';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: AspectRatio(
            aspectRatio: 1.8,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Сергей Кольцов',
                                  style: TextStyle(fontSize: 28),
                                ),
                                Text(
                                  'Яндекс',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Spacer(flex: 1),
                              Flexible(
                                flex: 2,
                                child: IconButton(
                                  iconSize: 32,
                                  onPressed: () {},
                                  icon: const Icon(
                                    // TODO telegram
                                    Icons.cloud_circle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: IconButton(
                                  iconSize: 32,
                                  onPressed: () {},
                                  icon: const Icon(
                                    // TODO github
                                    Icons.account_circle,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: IconButton(
                                  iconSize: 32,
                                  onPressed: () {},
                                  icon: const Icon(
                                    // TODO email
                                    Icons.circle_notifications,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 1),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Image.asset(
                        _tgAvatar,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
