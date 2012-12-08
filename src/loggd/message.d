
module loggd.message;

import std.datetime;
import std.string;
import loggd.core;

/**
 *
 */
struct Message
{
	string message;
	Level level;
	string loggerName;
	uint count;
	string type;
	SysTime time;
	//uint line;
	//string file;

	string toString() {
		return format("message{%s, %s}",
			getLevelString(level),
			message
		);
	}

}

