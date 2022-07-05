import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cv_icons.dart';
import 'logger.dart';

const _tgAvatar = 'assets/ava.jpeg';

class Links {
  static const github = 'https://github.com/kltsv';
  static const telegram = 'https://t.me/ringov';
  static const email = 'ringov@yandex-team.ru';

  const Links._();
}

void main() {
  initLogger();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _isDark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => Material(
          child: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    onPressed: () {
                      final newMode = !_isDark;
                      logger.info(
                        'Switch theme mode: '
                        '${_isDark.asThemeName} -> ${newMode.asThemeName}',
                      );
                      setState(() => _isDark = newMode);
                    },
                    icon: Icon(
                      _isDark ? Icons.sunny : Icons.nightlight_round,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        theme: _isDark ? ThemeData.dark() : ThemeData.light(),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: CVCard(),
        ),
      ),
    );
  }
}

class CVCard extends StatelessWidget {
  const CVCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CVCardContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Flexible(
            flex: 3,
            child: InfoWidget(),
          ),
          Flexible(
            flex: 2,
            child: AvatarWidget(),
          ),
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: IdentityWidget(),
        ),
        LinksWidget(),
      ],
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _tgAvatar,
      fit: BoxFit.fitHeight,
      frameBuilder: (_, child, frame, ___) => AnimatedOpacity(
        duration: const Duration(milliseconds: 1500),
        opacity: frame != null ? 1.0 : 0,
        child: frame != null ? child : Container(),
      ),
    );
  }
}

class IdentityWidget extends StatelessWidget {
  const IdentityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Сергей Кольцов',
          style: TextStyle(fontSize: 28, fontFamily: 'Roboto'),
        ),
        Text(
          'Яндекс',
          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}

class LinksWidget extends StatelessWidget {
  const LinksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(flex: 1),
        Flexible(
          flex: 2,
          child: LinkIcon(
            icon: CVIcons.telegram,
            onPressed: () {
              logger.info('Open Telegram: ${Links.telegram}');
              launchUrl(Uri.parse(Links.telegram));
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: LinkIcon(
            icon: CVIcons.github,
            onPressed: () {
              logger.info('Open Github: ${Links.github}');
              launchUrl(Uri.parse(Links.github));
            },
          ),
        ),
        Flexible(
          flex: 2,
          child: LinkIcon(
            icon: CVIcons.email,
            onPressed: () {
              logger.info('Copy email: ${Links.email}');
              Clipboard.setData(
                const ClipboardData(text: Links.email),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Скопировано'),
                ),
              );
            },
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}

class CVCardContainer extends StatelessWidget {
  static const _borderRadius = 16.0;
  final Widget child;

  const CVCardContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: child,
        ),
      ),
    );
  }
}

class LinkIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const LinkIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}

extension _BoolToThemeName on bool {
  String get asThemeName => this ? 'dark' : 'light';
}
