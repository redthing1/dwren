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

	string module_name;
	string script_source;
	if (args.length <= 1) {
		// basic print test
		module_name = "test_module";
		script_source = "System.print(\"I am running in a VM!\")";
	} else {
		// load file
		auto script_file = args[1];
		immutable auto file_contents = std.file.readText(script_file);
		module_name = dirName(script_file);
		script_source = file_contents;
	}
	immutable WrenInterpretResult result = wrenInterpret(vm, module_name.c_str, script_source.c_str);
	switch (result) {
	case WrenInterpretResult.WREN_RESULT_COMPILE_ERROR: {
			printf("compile error!\n");
		}
		break;
	case WrenInterpretResult.WREN_RESULT_RUNTIME_ERROR: {
			printf("runtime error!\n");
		}
		break;
	case WrenInterpretResult.WREN_RESULT_SUCCESS: {
			printf("success!\n");
		}
		break;
		default: break;
	}

	wrenFreeVM(vm);
}

extern (C) void writeFn(WrenVM* vm, const char* text) {
	printf("%s", text);
}
