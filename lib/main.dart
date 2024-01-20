import 'package:cvapp/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_theme.dart';
import 'components/card_container.dart';
import 'components/link_icon.dart';
import 'cv_icons.dart';
import 'error_handler.dart';
import 'logger.dart';
import 's.dart';

const _tgAvatar = 'assets/ava.jpeg';

class Links {
  static const github = 'https://github.com/kltsv';
  static const telegram = 'https://t.me/flutterbro';
  static const email = 'srg.koltsov@yandex.ru';

  const Links._();
}

void main() {
  initLogger();
  logger.info('Start main');
  ErrorHandler.init();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _isDark = false;
  var _locale = S.en;

  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.supportedLocales,
        locale: _locale,
        builder: (context, child) => SafeArea(
          child: Material(
            child: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkResponse(
                          child: AppText(_locale.languageCode.toUpperCase()),
                          onTap: () {
                            final newLocale = S.isEn(_locale) ? S.ru : S.en;
                            logger.info(
                              'Switch language: '
                              '${_locale.languageCode} -> ${newLocale.languageCode}',
                            );
                            setState(() => _locale = newLocale);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        theme: AppTheme.theme(_isDark),
        home: const HomePage(),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
          child: const Padding(
            padding: EdgeInsets.all(14.0),
            child: CVCard(),
          ),
        ),
      ),
    );
  }
}

class CVCard extends StatelessWidget {
  const CVCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CVCardContainer(
      front: CVFront(),
      // TODO add this for flipping cv card
      // back: CVBack(),
    );
  }
}

class CVFront extends StatelessWidget {
  const CVFront({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 3,
          child: InfoWidget(),
        ),
        Flexible(
          flex: 2,
          child: AvatarWidget(),
        ),
      ],
    );
  }
}

class CVBack extends StatelessWidget {
  const CVBack({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO add any info you like
    return const Center(child: Text('Hello world!'));
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
  const AvatarWidget({super.key});

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(child: AppTitle(S.of(context).name)),
        FittedBox(child: AppSubtitle(S.of(context).company)),
      ],
    );
  }
}

class LinksWidget extends StatelessWidget {
  const LinksWidget({
    super.key,
  });

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
                SnackBar(
                  content: AppText(S.of(context).copied),
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

extension _BoolToThemeName on bool {
  String get asThemeName => this ? 'dark' : 'light';
}
