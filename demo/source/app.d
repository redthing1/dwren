import std.stdio;
import wren;

void main() {
	// create wren config
	WrenConfiguration config;
	wrenInitConfiguration(&config);
	config.writeFn = &writeFn; // set write

	// create vm
	WrenVM* vm = wrenNewVM(&config);

	// execute print code
	WrenInterpretResult result = wrenInterpret(vm, "my_module",
			"System.print(\"I am running in a VM!\")");
}

extern (C) void writeFn(WrenVM* vm, const char* text) {
	printf("%s", text);
}
