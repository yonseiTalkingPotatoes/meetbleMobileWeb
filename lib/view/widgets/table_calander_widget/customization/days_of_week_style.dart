// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/widgets.dart';

import '../shared/utils.dart' show TextFormatter;

/// Class containing styling for `TableCalendar`'s days of week panel.
class DaysOfWeekStyle {
  /// Use to customize days of week panel text (e.g. with different `DateFormat`).
  /// You can use `String` transformations to further customize the text.
  /// Defaults to simple `'E'` format (i.e. Mon, Tue, Wed, etc.).
  ///
  /// Example usage:
  /// ```dart
  /// dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
  /// ```
  final TextFormatter? dowTextFormatter;

  /// Decoration for the top row of the table
  final Decoration decoration;

  /// Style for weekdays on the top of calendar.
  final TextStyle weekdayStyle;

  /// Style for weekend days on the top of calendar.
  final TextStyle weekendStyle;

  /// Creates a `DaysOfWeekStyle` used by `TableCalendar` widget.
  const DaysOfWeekStyle({
    this.dowTextFormatter,
    this.decoration = const BoxDecoration(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      border: Border(
          bottom: BorderSide(
              color: Color(0xFF000000),
              width: 0.7
          )
      ),
    ),
    this.weekdayStyle = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: Color(0xFF000000),
    ),
    this.weekendStyle = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: Color(0xFF000000),
    ),
  });
}