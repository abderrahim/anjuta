/**
 * SECTION:ianjuta-document-manager
 * @title: IAnjutaDocumentManager
 * @short_description: Interface for plugin that manages all the editors
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public errordomain IAnjuta.DocumentManagerError
{
	DOESNT_EXIST
}

public interface IAnjuta.DocumentManager : Object
{
	/**
	 * IANJUTA_DOCUMENT_MANAGER_CURRENT_DOCUMENT
	 *
	 * Anjuta shell value set by document manager to the current document
	 */
	public const string CURRENT_DOCUMENT = "document_manager_current_document";

	/**
	 * ianjuta_document_manager_get_file:
	 * @self: Self
	 * @filename: short filename
	 * @error: Error propagation and reporting.
	 *
	 * Given the short filename, finds the file of the filename, if the
	 * editor that has it loaded is found. If there is no editor that has
	 * this file opened, returns NULL.
	 *
	 * Return value: the GFile for the given short filename
	 */
	public abstract GLib.File? get_file (string filename) throws Error;

	/**
	 * ianjuta_document_manager_find_document_with_file:
	 * @self: Self
	 * @file: The file to find.
	 * @error: Error propagation and reporting.
	 *
	 * Finds the document that has the file  loaded. Only
	 * the editor that matches the file will be searched.
	 *
	 * Return value: the document that corresponds to given file. NULL if
	 * there is no editor loaded with this file.
	 */
	public abstract Document? find_document_with_file (GLib.File file) throws Error;

	/**
	 * ianjuta_document_manager_goto_file_line:
	 * @self: Self
	 * @file: file to go to.
	 * @lineno: the line number in the file to go to.
	 * @error: Error propagation and reporting.
	 *
	 * Loads the given file if not loaded yet, set its editor as current editor
	 * and moves cursor to the given line in the editor.
	 *
	 * Return value: the editor where the mark has been put. NULL if none.
	 */
	public abstract Editor? goto_file_line (GLib.File file, int lineno) throws Error;

	/**
	 * ianjuta_document_manager_goto_file_line_mark:
	 * @self: Self
	 * @file: file to go to.
	 * @lineno: the line number in the file to go to.
	 * @mark: TRUE if the line should be marked with a marker.
	 * @error: Error propagation and reporting
	 *
	 * Loads the given file if not loaded yet, set its editor as current editor
	 * and moves cursor to the given line in the editor. Optionally also marks
	 * the line with line marker if @mark is given TRUE.
	 *
	 * Return value: the editor where the mark has been put. NULL if none.
	 */
	public abstract Editor? goto_file_line_mark (GLib.File file, int lineno, bool mark) throws Error;

	/**
	 * ianjuta_document_manager_get_current_document:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Gets the current document.
	 *
	 * Return value: the currently active document. NULL if none is there.
	 */
	public abstract Document? get_current_document () throws Error;

	/**
	 * ianjuta_document_manager_set_current_document:
	 * @self: Self
	 * @document: the document to set as current.
	 * @error: Error propagation and reporting.
	 *
	 * Sets the given document as current document.
	 */
	public abstract void set_current_document (Document document) throws Error;

	/**
	 * ianjuta_document_manager_get_doc_widgets:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Gets a list of widgets for open documents. Each widget is
	 * a GTK_WIDGET(IAnjutaDocument*)
	 *
	 * Return value: a list of widgets for all open documents
	 * The returned list (but not the data in the list) must be
	 * freed after use.
	 */
	/* FIXME */
	public abstract List<Gtk.Widget> get_doc_widgets () throws Error;

	/**
	 * ianjuta_document_manager_add_buffer:
	 * @self: Self
	 * @name: Name of the editor buffer.
	 * @content: Initial content of the buffer.
	 * @error: Error propagation and reporting.
	 *
	 * Creates a new editor buffer of the given name and sets the given
	 * content as its initial content.
	 *
	 * Return value: the IAnjutaEditor instance that has been added.
	 */
	public abstract Editor add_buffer (string name, string content) throws Error;

	/**
	 * ianjuta_document_manager_remove_document:
	 * @self: Self
	 * @document: Document to close.
	 * @save_before: If true, saves the document before closing.
	 * @error: Error propagation and reporting.
	 *
	 * Closes and removes the given document. If @save_before is TRUE, also
	 * saves the document before closing.
	 *
	 * Return value: TRUE if the document was removed, else FALSE.
	 */
	public abstract bool remove_document (Document document, bool save_before) throws Error;

	/**
	 * ianjuta_document_manager_add_document:
	 * @self: Self
	 * @document: the document to add
	 * @error: Error propagation and reporting.
	 *
	 * Adds a document to the document manager. This will open a new
	 * Notebook tab and show the document there
	 *
	 */
	public abstract void add_document (Document document) throws Error;

	/*
	 * ianjuta_document_manager_add_bookmark:
	 * @self: Self
	 * @file: File to add the bookmark
	 * @line: Line of the bookmark
	 *
	 * Add a bookmark
	 */
	public abstract void add_bookmark (GLib.File file, int line) throws Error;
}
