
module loggd.util;

import std.conv;
import std.datetime;

class StringBuilder
{
	private {
		size_t len = 0;
		char[] str = [];
	}

	this (string s = "") {
		str = s.dup;
		len = s.length;
	}

	auto append(T)(T item) {
		static if (is(T == string)) {
			appendString(item);
		} else {
			appendString(to!string(item));
		}
		return this;
	}

	private void appendString(string s) {
		auto newLen = len + s.length;
		if (newLen > str.length) {
			str.length +=  cast(size_t)(newLen * 1.5);
		}
		str[len .. len + s.length] = s;
		len += s.length;
	}

	void clear() {
		len = 0;
		str = [];
	}

	string toString() {
		return to!string(str[0 .. len]);
	}

	auto opBinary(string op, T)(T rhs) {
		static if (op == "~") {
			return append(rhs);
		}
	}

}

/**
 * Returns a formatted string for the given SysTime struct.
 */
auto getTimeString(SysTime time)
{
	return DateTime(cast(Date)time, cast(TimeOfDay)time).toSimpleString();
}

