
module loggd.logger;

import std.datetime;

import loggd.core;
import loggd.logmanager;

/**
 *
 */
abstract class AbstractLogger
{
	/**
	 *
	 */
	void log(Level level, string message);

	/**
	 *
	 */
	Level getLevel();

	/**
	 *
	 */
	void setLevel(Level l);

	/**
	 *
	 */
	bool isEnabled();
}


/**
 *
 */
class Logger : AbstractLogger
{
	private {
		Level level;
		string name;
		Handler[] handlers;
		uint count;
		bool useParent;
	}
	package Logger parent;

	package this(string name, Logger parent = null) {
		this.name = name;
		this.parent = parent;
		this.count = 0;
		bool useParent = true;
		handlers.length = 0;
		//handlers[0] = new ConsoleHandler(Level.INFO);
	}

	static Logger getLogger(string name) {
		version (nologging) {
			if (!nullLogger) {
				nullLogger = new NullLogger("");
			}
			return nullLogger;
		} else {
			return getLogger(name);
		}
	}

	auto getParent() {
		return parent;
	}

	auto getName() {
		return name;
	}

	void setLevel(Level level) {
		this.level = level;
	}

	Level getLevel() {
		return level;
	}

	bool isEnabled() {
		return level != Level.OFF;
	}

	bool isEnabledFor(Level l) {
		return l <= this.level;
	}

	auto useParentLogger(bool useParent) {
		this.useParent = useParent;
	}

	void addHandler(Handler h) {
		if (handlers) {
			handlers ~= [h];
		} else {
			handlers = [h];
		}
	}

	void info(string message="") {
		log(Level.INFO, message);
	}

	void trace(string message="") {
		log(Level.TRACE, message);
	}

	void warn(string message="") {
		log(Level.WARN, message);
	}

	void error(string message="") {
		log(Level.ERROR, message);
	}

	void fatal(string message="") {
		log(Level.FATAL, message);
	}

	/**
	 *
	 */
	void log(Level l, string message = "") {
		//debug {
			//std.stdio.writeln(
				//"log():\n\tname: ", name,
				//"\n\tlevel: ", l,
				//"\n\tmessage: ", message);
		//}

		if (l <= this.level) {
			doLog(l, message);
		}

		if (useParent && parent) {
			parent.log(l, message);
		}
	}

	// private support method for logging.
	// We fill in the logger name, resource bundle name, and
	// resource bundle and then call "void log(LogRecord)".
	private void doLog(Level l, string msg, int line = -1) {

		Message m;
	    m.message = msg;
	    m.level = l;
	    m.loggerName = this.name;
	    m.count = this.count;
		m.time = Clock.currTime();

		//if (line >= 0)
			//r.line = line;

		foreach (handler; handlers) {
			handler.handle(m);
		}
		++count;
	}
}

/**
 *
 */
class NullLogger : Logger
{
	package this(string name, Logger parent = null) {
		super(name, parent);
	}

	void log(Level level, string message) {}

	Level getLevel() { return Level.OFF; }

	void setLevel(Level l) {}

	bool isEnabled() { return false; }
}

NullLogger nullLogger;


