
/**
 * SECTION:ianjuta-editor-language
 * @title: IAnjutaEditorLanguage
 * @short_description: Text editor language interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.EditorLanguage : Editor
{
	/* IAnjutaEditorLanguage::language-changed:
	 * @self: self
	 * @language: new language
	 *
	 * the language of the editor changed to @language
	 */
	public virtual signal void language_changed (string language);

	/**
	 * ianjuta_editor_language_get_supported_languages:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Return a list of languages supported by the editor
	 * Note: These list contains the names in the form
	 * the editor implementation knows them
	 *
	 */
	public abstract unowned List<string> get_supported_languages () throws Error;

	/**
	 * ianjuta_editor_language_name:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get a list of languages the editor can highlight
	 *
	 */
	public abstract unowned string get_language_name (string language) throws Error;

	/**
	 * ianjuta_editor_language_get_language:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Return the name of the currently used language
	 *
	 */
	public abstract unowned string get_language () throws Error;

	/**
	 * ianjuta_editor_language_set_language:
	 * @self: Self
	 * @language: Language
	 * @error: Error propagation and reporting
	 *
	 * Force the editor to use a given language
	 *
	 */
	public abstract void set_language (string language) throws Error;
}
