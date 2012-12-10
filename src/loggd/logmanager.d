
module loggd.logmanager;

import loggd.core;

import std.array;
import std.conv;
import std.file;
import std.json;
import std.stdio;
import std.string;

private
{
	Logger root;
	Logger[string] loggerMap;
	Handler[string] handlerMap;
}

// module static initializer
static this()
{
	writeln("loggd init!");
	root = new Logger("");
	root.addHandler(new ConsoleHandler(Level.INFO));
	loadConfiguration(".");
}

Logger getGlobalLogger()
{
	return root;
}

Logger getAnonymousLogger()
{
	return new Logger("");
}

Logger getLogger(string name="")
{
	if (name in loggerMap) {
		return loggerMap[name];
	}
	Logger l = new Logger(name);

	// set parent
	l.parent = findParent(l);

	loggerMap[name] = l;
	return l;
}

private Logger findParent(Logger l)
{
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

/**
 *
 */
class LoggingException : Exception
{
	this(string message="") {
		super(message);
	}
}


/**
 * Load logging configuration from a json file.
 */
void loadConfiguration(string path)
{
	auto filename = path ~ "/loggd.json";
	if (!exists(filename)) {
		writeln("could not find loggd.json configuration in '", path, "'");
	}

	auto json = parseJSON(to!string(read(filename)));
	auto handlerList = json.object["handlers"];
	loadHandlers(handlerList);
	loadLoggers(json.object["loggers"]);
}

private void loadLoggers(JSONValue list)
{
	foreach (item; list.array) {
		try {
			auto obj = item.object;
			Logger logger;

			if ("name" in obj) {
				logger = getLogger(obj["name"].str);
			}

			if ("level" in obj) {
				logger.setLevel(getLevel(obj["level"].str));
			}

			if ("handlers" in obj) {
				auto handlers = obj["handlers"].array;
				foreach (h; handlers) {
					if (h.str in handlerMap) {
						logger.addHandler(handlerMap[h.str]);
					}
				}
			}

		} catch (LoggingException e) {
			// TODO:
			debug std.stdio.writeln("invalid logger configuration: ", e);
		}
	}
}

private void loadHandlers(JSONValue list)
{
	foreach (item; list.array) {
		try {
			auto obj = item.object;
			Handler handler;

			if ("type" in obj) {
				handler = getHandler(obj["type"].str);
			} else {
				throw new LoggingException("Handler configuration must have a type attribute");
			}

			if ("level" in obj) {
				handler.setLevel(getLevel(obj["level"].str));
			}

			if ("name" in obj) {
				handlerMap[obj["name"].str] = handler;
			}

		} catch (LoggingException e) {
			// TODO:
			debug std.stdio.writeln("invalid handler configuration: ", e);
		}
	}
}

private void readJson(JSONValue obj)
{
	foreach (key; obj.object.keys) {
		writeln(key, " : ", obj.object[key].str);
	}
}

