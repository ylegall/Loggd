
module loggd.logmanager;

import std.array;
import std.string;
import std.stdio;

import loggd.core;


class LogManager
{
	private static LogManager instance;
	private {
		Logger root;
		Logger[string] loggerMap;
	}

	static this() {
		instance = new LogManager();
	}

	private this() {
		root = new Logger("");
		root.addHandler(new ConsoleHandler(Level.INFO));
	}

	/**
	 *
	 */
	static synchronized LogManager getInstance() {
		if (!instance) {
			instance = new LogManager();
		}
		return instance;
	}

	/**
	 *
	 */
	package Logger getLogger(string name="") {
		if (name in loggerMap) {
			return loggerMap[name];
		}
		Logger l = new Logger(name);

		// set parent
		l.parent = findParent(l);

		loggerMap[name] = l;
		return l;
	}

	Logger findParent(Logger l) {
		auto name = l.getName();
		if (!name || name=="") {
			return root;
		}
		while (name.length) {
			auto i = lastIndexOf(name, '.');
			if (i <= 0) {
				break;
			}
			name = name[0 .. i];
			if (name in loggerMap) {
				return loggerMap[name];
			}
		}
		return root;
	}
}

version(logmanager)
{
	import std.stdio;

	void main()
	{
		auto lm = LogManager.getInstance();
		auto logger = lm.getLogger("edu.pitt.cs");
		writeln(logger.getParent().getName());
	}
}

