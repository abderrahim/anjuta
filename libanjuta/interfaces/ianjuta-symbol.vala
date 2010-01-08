/**
 * SECTION:ianjuta-symbol
 * @title: IAnjutaSymbol
 * @short_description: Source code symbol interface
 * @see_also: #IAnjutaSymbolManager
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaSymbolType:
 * @IANJUTA_SYMBOL_TYPE_UNDEF: Unknown type. If you have to search for all the known
 * types use this flag because it's quicker than #IANJUTA_SYMBOL_TYPE_MAX.
 * @IANJUTA_SYMBOL_TYPE_CLASS: Class declaration
 * @IANJUTA_SYMBOL_TYPE_ENUM: Enum declaration
 * @IANJUTA_SYMBOL_TYPE_ENUMERATOR: Enumerator value
 * @IANJUTA_SYMBOL_TYPE_FIELD: Field (Java only)
 * @IANJUTA_SYMBOL_TYPE_FUNCTION: Function definition
 * @IANJUTA_SYMBOL_TYPE_INTERFACE: Interface (Java only)
 * @IANJUTA_SYMBOL_TYPE_MEMBER: Member variable of class/struct
 * @IANJUTA_SYMBOL_TYPE_METHOD: Class method (Java only)
 * @IANJUTA_SYMBOL_TYPE_NAMESPACE: Namespace declaration
 * @IANJUTA_SYMBOL_TYPE_PACKAGE: Package (Java only)
 * @IANJUTA_SYMBOL_TYPE_PROTOTYPE: Function prototype
 * @IANJUTA_SYMBOL_TYPE_STRUCT: Struct declaration
 * @IANJUTA_SYMBOL_TYPE_TYPEDEF: Typedef
 * @IANJUTA_SYMBOL_TYPE_UNION: Union
 * @IANJUTA_SYMBOL_TYPE_VARIABLE: Variable
 * @IANJUTA_SYMBOL_TYPE_EXTERNVAR: Extern or forward declaration
 * @IANJUTA_SYMBOL_TYPE_MACRO: Macro (without arguments)
 * @IANJUTA_SYMBOL_TYPE_MACRO_WITH_ARG: Parameterized macro
 * @IANJUTA_SYMBOL_TYPE_FILE: File (Pseudo tag)
 * @IANJUTA_SYMBOL_TYPE_OTHER: Other (non C/C++/Java tag)
 * @IANJUTA_SYMBOL_TYPE_SCOPE_CONTAINER: types which are subjected to create a scope.
 * @IANJUTA_SYMBOL_TYPE_MAX: Maximum value, means all known values. You can reach
 * the same result using IANJUTA_SYMBOL_TYPE_UNDEF, which is much faster.
 */
[Flags]
public enum IAnjuta.SymbolType
{
	UNDEF = 1,
	CLASS = 2,
	ENUM = 4,
	ENUMERATOR = 8,
	FIELD = 16,
	FUNCTION = 32,
	INTERFACE = 64,
	MEMBER = 128,
	METHOD = 256,
	NAMESPACE = 512,
	PACKAGE = 1024,
	PROTOTYPE = 2048,
	STRUCT = 4096,
	TYPEDEF = 8192,
	UNION = 16384,
	VARIABLE = 32768,
	EXTERNVAR = 65536,
	MACRO = 131072,
	MACRO_WITH_ARG = 262144,
	FILE = 524288,
	OTHER = 1048576,
	//SCOPE_CONTAINER = CLASS | ENUM | ENUMERATOR | INTERFACE | NAMESPACE | PACKAGE | STRUCT | TYPEDEF | UNION,
	SCOPE_CONTAINER = 30286,
	MAX = 2097151
}

/**
 * IAnjutaSymbolField:
 * @IANJUTA_SYMBOL_FIELD_SIMPLE: With this field you will have name, line of declaration,
 *                               is_file_scope and signature of the symbol.
 * @IANJUTA_SYMBOL_FIELD_FILE_PATH: The path to the file. It's obtained using something like
 *									g_strconcat ("/home/user/project_dir/",
 *									"src/db/realative/path/file.c");
 * @IANJUTA_SYMBOL_FIELD_IMPLEMENTATION: implementation attribute of a symbol. It may be
 *										"pure virtual", "virtual", etc.
 * @IANJUTA_SYMBOL_FIELD_ACCESS: access attribute of a symbol. It may be "public", "private" etc.
 * @IANJUTA_SYMBOL_FIELD_KIND: kind attribute of a symbol. "enumerator", "namespace", "class" are
 *							  some examples.
 * @IANJUTA_SYMBOL_FIELD_TYPE: type attribute of a symbol. Use this field in conjunction with
 *						#IANJUTA_SYMBOL_FIELD_TYPE_NAME as the query would retrieve both
 *						attributes in a quicker way.
 * @IANJUTA_SYMBOL_FIELD_TYPE_NAME: type_name attribute of a symbol. If a type could be
 *									"class" then its type_name may be "MyFooClass" etc.
 * @IANJUTA_SYMBOL_FIELD_LANGUAGE: the language of the symbol, e.g. "C", "Java", etc.
 * @IANJUTA_SYMBOL_FIELD_FILE_IGNORE: field mainly ignored.
 * @IANJUTA_SYMBOL_FIELD_FILE_INCLUDE: field mainly ignored.
 * @IANJUTA_SYMBOL_FIELD_PROJECT_NAME: the project this symbol belongs to.
 * @IANJUTA_SYMBOL_FIELD_WORKSPACE_NAME: the workspace this symbol belongs to.
 *
 * Field masks. Used mainly to retrieve the fields of a symbol
 * throught the call to ianjuta_symbol_get_extra_info_string () or the various
 * ianjuta_symbol_manager_* () functions.
 */
[Flags]
public enum IAnjuta.SymbolField
{
	SIMPLE = 1,
	FILE_PATH = 2,
	IMPLEMENTATION = 4,
	ACCESS = 8,
	KIND = 16,
	TYPE = 32,
	TYPE_NAME = 64,
	LANGUAGE = 128,
	FILE_IGNORE = 256,
	FILE_INCLUDE = 512,
	PROJECT_NAME = 1024,
	WORKSPACE_NAME = 2048
}

public interface IAnjuta.Symbol : Object
{
	/**
	 * ianjuta_symbol_get_id:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * An unique identifier for the symbol: pay attention that when engine re-parse
	 * the files this id may change.
	 *
	 * Returns: 0 on error, otherwise the id of the symbol mapped in the db.
	 */
	public abstract int get_id () throws Error;

	/**
	 * ianjuta_symbol_get_name:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns: The name of the symbol
	 */
	public abstract unowned string get_name () throws Error;

	/**
	 * ianjuta_symbol_get_file:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns: The file where the symbol is declared in.
	 */
	public abstract GLib.File get_file() throws Error;

	/**
	 * ianjuta_symbol_get_line:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns: Line of the file the symbol is declared in.
	 */
	public abstract ulong get_line () throws Error;

	/**
	 * ianjuta_symbol_is_local:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Is the symbol a static (private) one?
	 *
	 * Returns: TRUE if the symbol is local (private, etc), FALSE elsewhere.
	 */
	public abstract bool is_local () throws Error;

	/**
	 *ianjuta_symbol_get_args:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
 	 *
	 * If symbol has a kind "function" then this will return a string with the args of the
	 * function itself.
	 *
	 * Returns: args as const string or NULL
	 */
	public abstract unowned string? get_args () throws Error;

	/**
	 *ianjuta_symbol_get_returntype:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
 	 *
	 * If symbol has a kind "function" then this will return a string with the
	 * return type of the function itself.
	 *
	 * Returns: returntype as const string or NULL
	 */
	public abstract unowned string? get_returntype () throws Error;

	/**
	 * ianjuta_symbol_get_sym_type:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * You can obtain an IAnjutaSymbolType of the symbol.
	 * To have a string representation see ianjuta_symbol_get_extra_info_string ().
	 * You *need* a symbol with #IANJUTA_SYMBOL_FIELD_TYPE enabled attribute. e.g. use ianjuta_symbol_manager_search
	 * passing #IANJUTA_SYMBOL_FIELD_TYPE as info_fields.
	 *
	 * Returns: a #IAnjutaSymbolType
	 */
	public abstract Type get_sym_type () throws Error;

	/**
	 * ianjuta_symbol_get_extra_info_string:
	 * @self: Self
 	 * @sym_info: Just one IANJUTA_SYMBOL_FIELD_* per time. It is NOT possible to pass something like
	 * FIELD_1 | FIELD_2 | ....
	 * Note: You will not have anything passing IANJUTA_SYMBOL_FIELD_SIMPLE, just a NULL value.
	 * @error: Error propagation and reporting.
	 *
	 * Returns: a string representation of the field required. For instance passing
	 * IANJUTA_SYMBOL_FIELD_FILE_PATH you'll have a const string representing the absolute file path,
	 * passing IANJUTA_SYMBOL_FIELD_ACCESS the access attribute, as "public", "private", etc.
 	 */
	public abstract unowned string get_extra_info_string (IAnjuta.SymbolField sym_info) throws Error;

	/**
	 * ianjuta_symbol_get_icon:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * You *need* a symbol with #IANJUTA_SYMBOL_FIELD_ACCESS |
	 * #IANJUTA_SYMBOL_FIELD_KIND enabled attribute. e.g. use
	 * ianjuta_symbol_manager_search passing #IANJUTA_SYMBOL_FIELD_ACCESS |
	 * #IANJUTA_SYMBOL_FIELD_KIND as info_fields.
	 *
	 * Returns: a Pixbuf icon representing the symbol.
	 */
	public abstract unowned Gdk.Pixbuf get_icon () throws Error;
}
