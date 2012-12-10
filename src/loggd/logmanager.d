
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
 * Load logging configuration from a json file.
 */
void loadConfiguration(string path)
{
	auto filename = path ~ "/loggd.json";
	if (!exists(filename)) {
		writeln("could not find loggd.json configuration in '", path, "'");
	}

	auto json = parseJSON(to!string(read(filename)));

	readJson(json.object["logger"]);
}

private void readJson(JSONValue obj)
{
	foreach (key; obj.object.keys) {
		writeln(key, " : ", obj.object[key].str);
	}
}

