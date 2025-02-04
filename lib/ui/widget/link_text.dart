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
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:libretrack/locale.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String text;
  final bool selectable;
  final TextStyle? style;

  const LinkText({
    Key? key,
    required this.text,
    this.selectable = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linkStyle = TextStyle(
      color: Theme.of(context).accentColor,
    );
    Future<void> onOpen(LinkableElement link) async {
      if (await canLaunch(link.url)) {
        await launch(link.url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).openLinkFailed),
          ),
        );
      }
    }

    if (selectable) {
      return SelectableLinkify(
        text: text,
        linkStyle: linkStyle,
        style: style,
        onOpen: onOpen,
      );
    } else {
      return Linkify(
        text: text,
        linkStyle: linkStyle,
        style: style,
        onOpen: onOpen,
      );
    }
  }
}
