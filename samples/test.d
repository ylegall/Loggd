
import loggd.core;

import std.stdio;

void main()
{
	Logger logger = Logger.getLogger("core");

	logger.setLevel(Level.INFO);

	logger.trace("trace test");
	logger.info("info test");
	logger.log(Level.DEBUG, "debug test");
	logger.warn("warn test");
	logger.error("error test");
	logger.fatal("fatal test");
	logger.log(Level.ALL, "ALL test");
}

