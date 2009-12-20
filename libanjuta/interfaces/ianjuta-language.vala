/**
 * SECTION:ianjuta-language
 * @title: IAnjutaLanguage
 * @short_description: Interface to manager multiple programming languages
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Language : Object
{
	/*
	 * ianjuta_language_from_mime_type:
	 * @self: Self
	 * @mime_type: A mime type to get the language for
	 *
	 * Returns: A language Id or 0 in case no language was found
	 */
	public abstract int get_from_mime_type (string mime_type) throws Error;

	/*
	 * ianjuta_language_from_string:
	 * @self: Self
	 * @string: A string representation of the language. Note that multiple
	 * strings may describe the language like C++ and Cpp
	 *
	 * Returns: A language Id or 0 in case no language was found
	 */
	public abstract int get_from_string (string str) throws Error;

 	/*
	 * ianjuta_language_get_name:
	 * @self: Self
	 * @id: A valid language id
	 *
	 * Returns: The main name of the language. When you call ianjuta_language_from_string()
	 * before that method the string you get here might be different to the one you passed
	 * because the language might have multiple string representations
	 */
	public abstract unowned string get_name(int id) throws Error;

	/*
	 * ianjuta_language_get_strings
	 * @self: Self
	 * @id: A valid language id
	 *
	 * Returns: A list of strings that represent this language that language
	 */
	public abstract List<unowned string> get_strings(int id) throws Error;

	/*
	 * ianjuta_language_get_from_editor:
	 * @self: Self
	 * @editor: An object implementing IAnjutaEditorLanguage
	 * @error: Error propagation
	 *
	 * Convenience method to get the id directly from the editor
	 *
	 * Returns: A valid language id or 0
	 */
	public abstract int get_from_editor (EditorLanguage editor) throws Error;

	/*
	 * ianjuta_language_get_name_from_editor:
	 * @self: Self
	 * @editor: An object implementing IAnjutaEditorLanguage
	 * @error: Error propagation
	 *
	 * Conviniece method to get the name directly from the editor
	 *
	 * Returns: A language name or NULL
	 */
	public abstract unowned string? get_name_from_editor (EditorLanguage editor) throws Error;

	/*
	 * ianjuta_language_get_languages:
	 * @self: Self
	 * @error: Error propagation
	 *
	 * Returns: a list of ids of the available languages. Use GPOINTER_TO_INT()
	 * to receive them. The list but not the values should be free'd with g_list_free()
	 */
	public abstract List<int> get_languages () throws Error;
}
