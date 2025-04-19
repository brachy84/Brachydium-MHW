
import 'package:talker/talker.dart';

typedef Json = Map<String, dynamic>;
typedef ToJson<T> = Json Function(T);
typedef FromJson<T> = T Function(Json);

final log = Talker(
  logger: TalkerLogger(
    formatter: _MyLogFormatter()
  )
);

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
