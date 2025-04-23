import 'package:talker/talker.dart';

typedef Json = Map<String, dynamic>;
typedef ToJson<T> = Json Function(T);
typedef FromJson<T> = T Function(Json);

final log = Talker(logger: TalkerLogger(formatter: _MyLogFormatter()));

class _MyLogFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    // removes message border
    final msg = details.message?.toString() ?? '';
    var lines = msg.split('\n');
    if (!settings.enableColors) {
      return lines.join('\n');
    }
    return lines.map((e) => details.pen.write(e)).toList().join('\n');
  }
}

extension InsertSorted<T> on List<T> {
  // finds a position in the list so that the new list is sorted
  // assumes that before inserting the list is sorted
  // this is much faster than sorting after inserting
  void addSorted(T t, [int Function(T a, T b)? compare]) {
    int low = 0;
    int high = length;

    compare ??= (a, b) => (a as Comparable<T>).compareTo(b);

    // binary search index
    while (low < high) {
      int mid = (low + high) >> 1;
      if (compare(t, this[mid]) < 0) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }

    insert(low, t);
  }
}

class NestedListHelper {
  static int getLargest<T>(List<List<T>> nested, [bool Function(List<T>)? test]) {
    int largest = -1;
    int size = 0;
    for (int i = 0; i < nested.length; i++) {
      List<T> l = nested[i];
      if ((test == null || test(l)) && (largest < 0 || l.length > size)) {
        largest = i;
        size = l.length;
      }
    }
    return largest;
  }
}
