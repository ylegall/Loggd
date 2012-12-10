
module loggd.handler;

import std.stdio;
import loggd.core;
import loggd.format;

/**
 *
 */
abstract class Handler
{
	private {
		Level level;
		string fmt;
	}

	/**
	 *
	 */
	this(Level level=Level.INFO, string fmt=DEFAULT_FORMAT) {
		this.level = level;
		this.fmt = fmt;
	}

	/**
	 *
	 */
	void handle(Message m) {
		if (m.level > this.level) {
			return;
		}
	}

	void setFormat(string fmt) {
		this.fmt = fmt;
	}

	void setLevel(Level level) {
		this.level = level;
	}
}

/**
 * Return a new instance of a Handler from the specified string.
 */
Handler getHandler(string str="ConsoleHandler")
{
	switch (str)
	{
		case "ConsoleHandler":
			return new ConsoleHandler();
		case "FileHandler":
			return new FileHandler();
		default:
			throw new Exception("unknown Handler type: " ~ str);
	}
}

/**
 *
 */
class ConsoleHandler : Handler
{
	this(Level level = Level.INFO, string fmt=DEFAULT_FORMAT) {
		super(level, fmt);
	}

	override
	void handle(Message m) {
		if (m.level > this.level) {
			return;
		}

		if (m.level <= Level.WARN) {
			stderr.writeln(format(fmt, m));
		} else {
			stdout.writeln(format(fmt, m));
		}
	}
}

class FileHandler : Handler
{

}


unittest
{
}

