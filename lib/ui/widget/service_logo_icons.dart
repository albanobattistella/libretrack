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

import 'rrect_icon.dart';

// ignore: avoid_classes_with_only_static_members
class ServiceLogoIconsData {
  static RRectIconData ups = RRectIconData.widget(
    icon: Image.asset('assets/service_logo/ups.png'),
    backgroundColor: const Color(0xff301406),
  );

  static RRectIconData russianPost = RRectIconData.widget(
    icon: Image.asset('assets/service_logo/russian_post.png'),
    backgroundColor: const Color(0xff0055a5),
  );
}
