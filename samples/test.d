
import loggd.core;

import std.stdio;

void main()
{
	//auto logger = getLogger("core");
	auto logger = getGlobalLogger();

	logger.setLevel(Level.INFO);

	logger.trace("trace test");
	logger.info("info test");
	logger.log(Level.DEBUG, "debug test");
	logger.warn("warn test");
	logger.error("error test");
	logger.fatal("fatal test");
	logger.log(Level.ALL, "ALL test");
}

