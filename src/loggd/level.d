
module loggd.level;

import loggd.core;

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

