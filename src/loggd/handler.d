
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
	this(Level level, string fmt=DEFAULT_FORMAT) {
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
}

/**
 *
 */
class ConsoleHandler : Handler
{
	this(Level l, string fmt=DEFAULT_FORMAT) {
		super(l, fmt);
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

class FileHandler
{

}

unittest
{
}

