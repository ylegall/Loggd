
module loggd.level;

import loggd.core;
import std.string;

/**
 *
 */
enum Level : int
{
	OFF    = 0,
	FATAL  = 100,
	ERROR  = 200,
	WARN   = 300,
	INFO   = 400,
	DEBUG  = 500,
	TRACE  = 600,
	ALL    = int.max
}

/**
 *
 */
string getLevelString(Level l) {
	switch (l)
	{
		case Level.OFF:
			assert (false, "logging is turned off");
		case Level.FATAL:
			return "FATAL";
		case Level.ERROR:
			return "ERROR";
		case Level.WARN:
			return "WARN";
		case Level.INFO:
			return "INFO";
		case Level.DEBUG:
			return "DEBUG";
		case Level.TRACE:
			return "TRACE";
		case Level.ALL:
			return "ALL";
		default:
			return "";
	}
}

/**
 * Returns a Level from a string
 */
Level getLevel(string str)
{
	str = str.toUpper();
	switch (str) {
		case "OFF":
			return Level.OFF;
		case "FATAL":
			return Level.FATAL;
		case "ERROR":
			return Level.ERROR;
		case "WARN":
			return Level.WARN;
		case "INFO":
			return Level.INFO;
		case "DEBUG":
			return Level.DEBUG;
		case "TRACE":
			return Level.TRACE;
		case "ALL":
			return Level.ALL;
		default:
			throw new Exception("invalid level: " ~ str);
	}
}

