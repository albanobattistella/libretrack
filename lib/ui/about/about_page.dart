// Copyright (C) 2021 Yaroslav Pronin <proninyaroslav@mail.ru>
// Copyright (C) 2021 Insurgo Inc. <insurgo@riseup.net>
//
// This file is part of LibreTrack.
//
// LibreTrack is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// LibreTrack is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with LibreTrack.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libretrack/ui/toast.dart';
import 'package:libretrack/ui/widget/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../locale.dart';
import '../theme.dart';
import 'about_cubit.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();

    context.read<AboutCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutState>(
      builder: (context, state) {
        return state.when(
          initial: () => const CircularProgressIndicator(),
          loading: () => const CircularProgressIndicator(),
          loaded: (appName, appVersion) {
            return _AboutDialog(
              appName: appName,
              appVersion: appVersion,
              appIcon: Icon(
                AppLogoInfo.foreground_logo,
                size: 48.0,
                color: AppTheme.palette(context).appLogoColor,
              ),
            );
          },
        );
      },
    );
  }
}

class _AboutDialog extends StatelessWidget {
  final String appName;
  final String appVersion;
  final Widget appIcon;

  const _AboutDialog({
    Key? key,
    required this.appName,
    required this.appVersion,
    required this.appIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _Header(
              appName: appName,
              appVersion: appVersion,
              appIcon: appIcon,
            ),
            LinkText(text: S.of(context).appDescription),
            const SizedBox(height: 8.0),
            LinkText(text: S.of(context).appLicense),
          ],
        ),
      ),
      actions: [
        const _ChangelogButton(),
        TextButton(
          child: Text(
            S.of(context).close,
            textAlign: TextAlign.end,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  static const _textVerticalSeparation = 18.0;

  final String appName;
  final String appVersion;
  final Widget appIcon;

  const _Header({
    Key? key,
    required this.appName,
    required this.appVersion,
    required this.appIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconTheme(
          data: Theme.of(context).iconTheme,
          child: appIcon,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListBody(
              children: [
                Text(
                  appName,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  appVersion,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: _textVerticalSeparation),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChangelogButton extends StatelessWidget {
  const _ChangelogButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        S.of(context).changelog,
        textAlign: TextAlign.end,
      ),
      onPressed: () async {
        final url = S.of(context).appChangelogUrl;
        if (await canLaunch(url)) {
          launch(url);
        } else {
          Toast.of(context).show(
            text: S.of(context).openLinkFailed,
          );
        }
      },
    );
  }
}
