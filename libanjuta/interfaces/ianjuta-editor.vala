/**
 * SECTION:ianjuta-editor
 * @title: IAnjutaEditor
 * @short_description: Text editor interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public errordomain IAnjuta.EditorError
{
	DOESNT_EXIST
}

/**
 * IAnjutaEditorAttribute:
 * @IANJUTA_EDITOR_TEXT: Normal text
 * @IANJUTA_EDITOR_KEYWORD: A keyword of the programming language
 * @IANJUTA_EDITOR_COMMENT: A comment
 * @IANJUTA_EDITOR_STRING: A string
 *
 * This enumeration is used to specify the type of text. Note that not all
 * editors implement this.
 */
[CCode (cprefix="IANJUTA_EDITOR_")]
public enum IAnjuta.EditorAttribute
{
	TEXT,
	KEYWORD,
	COMMENT,
	STRING
}

public interface IAnjuta.Editor : Object
{

	/**
	 * IAnjutaEditor::char-added:
	 * @position: The iter position where @ch is added.
	 * @ch: The character that has been added.
	 * @self: Self
	 *
	 * This signal is emitted when any character is added inside the editor.
	 * The newly added character is @ch which has been inserted at @position.
	 */
	public signal void char_added (Object position, char ch);

	/**
	 * IAnjutaEditor::backspace:
	 * @self: Self
	 *
	 * The signal is emitted when the user presses backspace
	 */
	public signal void backspace ();

	/**
	 * IAnjutaEditor::changed:
	 * @position: The iter position where change happend.
	 * @added: TRUE if added, FALSE if deleted.
	 * @length: Length of the text changed.
	 * @lines: Number of lines added or removed.
	 * @text: The text added or removed.
	 * @self: Self
	 *
	 * This signal is emitted when any text change happens in editor.
	 * The changes begin at @position. @text is not guaranteed to be NULL
	 * terminated. Use @length to read the text. @lines represent the
	 * number of line breaks in the added or removed text.
	 */
	/* FIXME */
	public signal void changed (Object position, bool added, int length, int lines, string text);

	/**
	 * ianjuta_editor_get_tabsize:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns the tabsize (in spaces) currently used by the editor.
	 *
	 * Returns: tabsize in number of spaces
	 */
	public abstract int get_tabsize () throws Error;

	/**
	 * ianjuta_editor_set_tabsize:
	 * @self: Self
	 * @tabsize: Tabsize in spaces
	 * @error: Error propagation and reporting
	 *
	 * Sets the tabsize of the editor.
	 */
	public abstract void set_tabsize (int tabsize) throws Error;

	/**
	 * ianjuta_editor_get_use_spaces:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Returns if the editor uses spaces for filling up tab characters.
	 *
	 * Returns: TRUE if yes, FALSE if no.
	 */
	public abstract bool get_use_spaces () throws Error;

	/**
	 * ianjuta_editor_set_use_space:
	 * @self: Self
	 * @use_spaces: TRUE to use spaces, FALSE to use tab char directly.
	 * @error: Error propagation and reporting
	 *
	 * Sets if the editor should use spaces for filling up tab characters.
	 */
	public abstract void set_use_spaces (bool use_spaces) throws Error;

	/**
	 * ianjuta_editor_set_auto_indent:
	 * @self: Self
	 * @auto_indent: TRUE to enable auto-indent, FALSE to disable
	 *
	 * Sets whether the editor should auto-indent itself. A plugin that does
	 * custom auto-indent can set this to false and override the preferences
	 * setting
	 */
	public abstract void set_auto_indent (bool auto_indent) throws Error;

	/**
	 * ianjuta_editor_erase_range:
	 * @self: Self
	 * @position_start: Start position of chars to erase.
	 * @position_end: End position of chars to erase.
	 * @error: Error propagation and reporting
	 *
	 * Erases the chars between positions pointed by @position_start and
	 * @position_end. The character pointed by @position_start is included,
	 * while pointed by @position_end is not include in the range. After
	 * the erase operation, all active iters, except these two, are no
	 * longer guranteed to be valid. At the end the operation, these two
	 * iters point to the same position which is the position where erase
	 * happend (usually the original @position_start position).
	 */
	public abstract void erase (Iterable position_start, Iterable position_end) throws Error;

 	/**
	 * ianjuta_editor_erase_all:
 	 * @self: Self
 	 * @error: Error propagation and reporting
 	 *
	 * Empties the whole editor buffer. There will be zero characters.
	 * After the erase operation, none of the active iters are guranteed
	 * to be valid.
 	 */
	public abstract void erase_all () throws Error;

	/**
	 * ianjuta_editor_insert:
	 * @self: Self
	 * @position: Character position in editor where insert will take place.
	 * @text: Text to append.
	 * @length: Length of @text to use.
	 * @error: Error propagation and reporting
	 *
	 * Inserts @length characters from @text buffer at given @position of
	 * editor buffer. If @length is -1, the whole @text is used.
	 */
	public abstract void insert (Iterable position, string text, int length) throws Error;

	/**
	 * ianjuta_editor_append:
	 * @self: Self
	 * @text: Text to append.
	 * @length: Length of @text to use.
	 * @error: Error propagation and reporting
	 *
	 * Appends @length characters from @text buffer at the end of editor
	 * buffer. If @length is -1, the whole @text is used. @length is in bytes.
	 */
	public abstract void append (string text, int length) throws Error;

	/**
	 * ianjuta_editor_goto_line:
	 * @self: Self
	 * @lineno: line number where carat will be moved.
	 * @error: Error propagation and reporting
	 *
	 * Carat is moved to the given @lineno line and text view is scrolled to
	 * bring it in viewable area of the editor.
	 */
	public abstract void goto_line (int lineno) throws Error;

	/**
	 * ianjuta_editor_goto_start:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Carat is moved to the begining of editor and text view is scrolled to
	 * bring it in viewable area of the editor.
	 */
	public abstract void goto_start () throws Error;

	/**
	 * ianjuta_editor_goto_end:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Carat is moved to the end of editor and text view is scrolled to
	 * bring it in viewable area of the editor.
	 */
	public abstract void goto_end () throws Error;

	/**
	 * ianjuta_editor_goto_position:
	 * @self: Self
	 * @position: Character position where carat will be moved.
	 * @error: Error propagation and reporting
	 *
	 * Carat is moved to the given @position and text view is scrolled to
	 * bring @position in viewable area of the editor.
	 */
	public abstract void goto_position (Iterable position) throws Error;

	/**
	 * ianjuta_editor_get_text:
	 * @self: Self
	 * @begin: Begining iterator
	 * @end: End iterator
	 * @error: Error propagation and reporting
	 *
	 * Gets text characters beginning from @begin (including char
	 * pointed by @begin) and ending with @end (excluding character
	 * pointed by @end). The characters returned are utf-8 encoded.
	 * The iterators @begin and @end could be in either order. The returned
	 * text, however, is in right order. If both @begin and @end points
	 * to the same position, NULL is returned.
	 *
	 * Returns: A buffer of utf-8 characters.
	 * The returned buffer must be freed when no longer required.
	 */
	public abstract string? get_text (Iterable begin, Iterable end) throws Error;

	/**
	 * ianjuta_editor_get_text_all:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Gets all text characters in the editor.
	 * The characters returned are utf-8 encoded.
	 *
	 * Returns: A buffer of utf-8 characters containing all text from editor.
	 * The returned buffer must be freed when no longer required.
	 */
	public abstract string get_text_all () throws Error;

	/**
	 * ianjuta_editor_line_from_position:
	 * @self: Self
	 * @position: Position you want to know the line from
	 * @error: Error propagation and reporting
	 *
	 * Get the line number in which @position locates.
	 * Returns: Line which corresponds to @position
	 *
	 */
	public abstract int get_line_from_position (Iterable position) throws Error;

	/**
	 * ianjuta_editor_get_lineno:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Obtains current line number on which carat is.
	 *
	 * Return value: Line number.
	 */
	public abstract int get_lineno () throws Error;

	/**
	 * ianjuta_editor_get_length:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get length of complete text in editor. This will be the total
	 * number of bytes in the file or buffer.
	 *
	 * Return value: Text length.
	 */
	public abstract int get_length () throws Error;

	/**
	 * ianjuta_editor_get_current_word:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Obtains the word on which carat is currently on.
	 *
	 * Return value: Current word.
	 */
	public abstract string get_current_word () throws Error;

	/**
	 * ianjuta_editor_get_current_column:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Obtains number of the current column in the editor.
	 *
	 * Return value: Current column.
	 */
	public abstract int get_column () throws Error;

	/**
	 * ianjuta_editor_get_line_begin_position:
	 * @self: Self
	 * @line: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract Iterable get_line_begin_position (int line) throws Error;

	/**
	 * ianjuta_editor_get_line_end_position:
	 * @self: Self
	 * @line: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract Iterable get_line_end_position (int line) throws Error;

	/**
	 * ianjuta_editor_get_overwrite:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Obtains editor overwirte mode: TRUE = Override, FALSE = Insert.
	 *
	 * Return value: editor mode.
	 */
	public abstract bool get_overwrite () throws Error;


	/**
	 * ianjuta_editor_set_popup_menu:
	 * @self: Self
	 * @menu: Popupmenu
	 * @error: Error propagation and reporting
	 *
	 * Set Editor popup menu. This is the menu shown in the editor when one
	 * right-clicks on it.
	 *
	 */
	public abstract void set_popup_menu (Gtk.Widget menu) throws Error;

	/*
	 * ianjuta_editor_get_offset:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get current caret position in integer character offset. Deprecated.
	 * Use ianjuta_editor_get_position() instead.
	 *
	 * Returns: Current character position since the begining of file.
	 */
	public abstract int get_offset () throws Error;

	/*
	 * ianjuta_editor_get_position:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get current caret position.
	 *
	 * Returns: Iterator that points to the current position.
	 */
	public abstract Iterable get_position () throws Error;

	/**
	 * ianjuta_editor_get_position_from_offset:
	 * @self: Self
	 * @offset: Character offset position where the iter will be set
	 * @error: Error propagation and reporting
	 *
	 * Creates and returns an iter for editor cells. The iter is
	 * placed at the unicode character position where the given offset
     * @offset happens to fall. The returned iter is cell (character)
	 * iter and not byte iter, so all iter operations
	 * on it are character (not byte) iteration, including all position
     * and index references in the iter.
     *
     * The iter must be unreferrenced by the caller when done.
	 * The iter navigates (next/previous) in step of unicode
	 * characters (one unicode character == one cell).
	 *
	 * Return value: a newly created iter of IAnjutaEditorCell placed at the
	 * given @offset position.
	 */
	public abstract Iterable get_position_from_offset (int offset) throws Error;

	/**
	 * ianjuta_editor_get_start_position:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Gets the iter positioned at the start of the editor buffer.
	 *
	 * Return value: Cell iter set to the begining of the editor.
	 */
	public abstract Iterable get_start_position () throws Error;

	/**
	 * ianjuta_editor_get_end_position:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Gets the iter positioned at the end of the editor buffer. The
	 * returned iter is the end-iter which does not point to any valid
	 * character in the buffer (it is pointed one step beyond the last
	 * valid character).
	 *
	 * Return value: Cell iter set to the end of the editor (end-iter).
	 */
	public abstract Iterable get_end_position () throws Error;
}
