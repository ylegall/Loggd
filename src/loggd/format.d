
module loggd.format;

import loggd.core;
import std.datetime;
import std.string;

const DEFAULT_FORMAT = "[%l] %t (%n): %m";

string format(Message m)
{
	return format(DEFAULT_FORMAT, m);
}

string format(string fmt, Message m)
{
	StringBuilder sb = new StringBuilder();
	for (int i = 0; i < fmt.length; ++i) {
		if (fmt[i] == '%') {
			i += 1;
			if (i >= fmt.length) {
				break;
			}

			switch (fmt[i]) {
				std.stdio.writeln(fmt[i]);
				case 'l':
					//sb.append(getLevelString(m.level));
					sb.append(m.level);
					break;
				case 'm':
					sb.append(m.message);
					break;
				case 'n':
					sb.append(m.loggerName);
					break;
				case 't':
					//sb.append(m.time.toSimpleString());
					sb.append(getTimeString(m.time));
					break;
				case 'c':
					sb.append(m.count);
					break;
				case '%':
					sb.append("%");
					break;
				default:
					break;
			}
		} else {
			sb.append(fmt[i]);
		}
	}
	return sb.toString();
}

