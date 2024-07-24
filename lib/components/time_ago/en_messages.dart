import '../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'lookup_message.dart';

/// English Messages
class EnMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() =>'';

  @override
  String lessThanOneMinute(int seconds) => LocaleKeys.now.tr();

  @override
  String aboutAMinute(int minutes) => "${LocaleKeys.before.tr()} 1 ${LocaleKeys.minute_ago.tr()}";

  @override
  String minutes(int minutes) => '${LocaleKeys.before.tr()} $minutes ${LocaleKeys.minute_ago.tr()}"';

  @override
  String aboutAnHour(int minutes) => "${LocaleKeys.before.tr()} 1 ${LocaleKeys.hours_ago.tr()}";

  @override
  String hours(int hours) => '$hours ${LocaleKeys.hours_ago.tr()}';

  @override
  String aDay(int hours) => "1 ${LocaleKeys.days_ago.tr()}";

  @override
  String days(int days) => '${LocaleKeys.before.tr()} $days ${LocaleKeys.days_ago.tr()}';

  @override
  String aboutAMonth(int days) => "${LocaleKeys.before.tr()} 1 ${LocaleKeys.month_ago.tr()}";

  @override
  String months(int months) => '${LocaleKeys.before.tr()} $months ${LocaleKeys.month_ago.tr()}';

  @override
  String aboutAYear(int year) => "1 ${LocaleKeys.year_ago.tr()}";

  @override
  String years(int years) => '$years ${LocaleKeys.year_ago.tr()}';

  @override
  String wordSeparator() => ' ';
}

/// English short Messages
class EnShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => 'now';

  @override
  String aboutAMinute(int minutes) => '1m';

  @override
  String minutes(int minutes) => '${minutes}m';

  @override
  String aboutAnHour(int minutes) => '~1h';

  @override
  String hours(int hours) => '${hours}h';

  @override
  String aDay(int hours) => '~1d';

  @override
  String days(int days) => '${days}d';

  @override
  String aboutAMonth(int days) => '~1mo';

  @override
  String months(int months) => '${months}mo';

  @override
  String aboutAYear(int year) => '~1y';

  @override
  String years(int years) => '${years}y';

  @override
  String wordSeparator() => ' ';
}
