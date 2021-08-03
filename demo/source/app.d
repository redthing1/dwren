import std.stdio;
import std.file;
import std.path;
import std.utf;
import wren;

public static char* c_str(string str) {
	return str.toUTFz!(char*)();
}

void main(string[] args) {
	// create wren config
	WrenConfiguration config;
	wrenInitConfiguration(&config);
	config.writeFn = &writeFn; // set write

	// create vm
	WrenVM* vm = wrenNewVM(&config);

	if (args.length <= 1) {
		// execute print code
		WrenInterpretResult result = wrenInterpret(vm, "my_module",
				"System.print(\"I am running in a VM!\")");
	} else {
		// load file
		auto script_file = args[1];
		auto file_contents = std.file.readText(script_file);
		WrenInterpretResult result = wrenInterpret(vm, dirName(script_file).c_str, file_contents.c_str);
	}
}

extern (C) void writeFn(WrenVM* vm, const char* text) {
	printf("%s", text);
}
