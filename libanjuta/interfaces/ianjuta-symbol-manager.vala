/**
 * SECTION:ianjuta-symbol-manager
 * @title: IAnjutaSymbolManager
 * @short_description: Source code symbols manager inteface
 * @see_also: #IAnjutaSymbol
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaSymbolManagerSearchFileScope:
 * You cannot use bitwise OR in this parameter.
 *
 * @IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE: to be ignored (e.g. Will search both private and public scopes).
 * @IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC: only global public function will be searched
 * (the ones that _do not_ belong to the file scope).
 * @IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE: only private or static (for C language) will be searched
 * (the ones that _do_ belong to the file scope).
 */
[CCode (cprefix="IANJUTA_SYMBOL_MANAGER_SEARCH_FS_")]
public enum IAnjuta.SymbolManagerSearchFileScope
{
	IGNORE = -1,
	PUBLIC = 1,
	PRIVATE = 0
}

public interface IAnjuta.SymbolManager : Object
{
	/**
	 * IAnjutaSymbolManager::prj_scan_end:
	 * @self: Self
	 *
	 * This signal is emitted when a scanning of one or more files on project db
	 * ends.
	 */
	public signal void prj_scan_end (int process_id);

	/**
	 * IAnjutaSymbolManager::prj_symbol_inserted:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is added to project db.
	 * The chain of symbols emitted is inserted, scan-end, removed.
	 */
	public signal void prj_symbol_inserted (int symbol_id);

	/**
	 * IAnjutaSymbolManager::prj_symbol_removed:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is removed from project db.
	 * The chain of symbols emitted is inserted, scan-end, removed.
	 */
	public signal void prj_symbol_removed (int symbol_id);

	/**
	 * IAnjutaSymbolManager::prj_symbol_updated:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is updated on project db.
	 * For 'update' we mean updating on all the fields which are not its primary key.
	 * Be sure to consider the following cases (comment from the core):
	 *
	 * #1. The symbol remains the same [at least on unique index key]. We will
	 *     perform only a simple update.
	 * #2. The symbol has changed: at least on name/type/file. We will insert a
	 *     new symbol on table 'symbol'. Deletion of old one will take place
	 *     at a second stage, when a delete of all symbols with
	 *     'tmp_flag = 0' will be done.
	 * #3. The symbol has been deleted. As above it will be deleted at
	 *     a second stage because of the 'tmp_flag = 0'. Triggers will remove
	 *     also scope_ids and other things.
	 */
	public signal void prj_symbol_updated (int symbol_id);

	/**
	 * IAnjutaSymbolManager::sys_scan_end:
	 * @self: Self
	 *
	 * This signal is emitted when a scanning of one or more packages on system db
	 * ends. This signal doesn't mean that all the scan process for the packages
	 * is ended, but that just one (or more) is (are).
	 */
	public signal void sys_scan_end (int process_id);

	/**
	 * IAnjutaSymbolManager::sys_symbol_inserted:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is added to system db.
	 * The chain of symbols emitted is inserted, scan-end, removed.
	 */
	public signal void sys_symbol_inserted (int symbol_id);

	/**
	 * IAnjutaSymbolManager::sys_symbol_removed:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is removed from system db.
	 * The chain of symbols emitted is inserted, scan-end, removed.
	 */
	public signal void sys_symbol_removed (int symbol_id);

	/**
	 * IAnjutaSymbolManager::sys_symbol_updated:
	 * @self: Self
	 *
	 * This signal is emitted when a new symbol is updated on system db.
	 * For 'update' we mean updating on all the fields which are not its primary key.
	 * Be sure to consider the following cases (comment from the core):
	 *
	 * #1. The symbol remains the same [at least on unique index key]. We will
	 *     perform only a simple update.
	 * #2. The symbol has changed: at least on name/type/file. We will insert a
	 *     new symbol on table 'symbol'. Deletion of old one will take place
	 *     at a second stage, when a delete of all symbols with
	 *     'tmp_flag = 0' will be done.
	 * #3. The symbol has been deleted. As above it will be deleted at
	 *     a second stage because of the 'tmp_flag = 0'. Triggers will remove
	 *     also scope_ids and other things.
	 */
	public signal void sys_symbol_updated (int symbol_id);

	/**
	 * ianjuta_symbol_manager_search:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @match_name: Name of the symbol you want to search for. If you just want to get all the
	 *              symbols then you need to use "%" as pattern. NULL _is not_ accepted.
	 * @partial_name_match: if TRUE it will search for %match_name%, it FALSE for the exact
	 * 					string match_name.
	 * @filescope_search: if #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC it will search only for public/extern functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE it will search also for static/private functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE it'll search for both public and private
	 * @global_tags_search: If TRUE it'll search only for system tags, using pkg-config to retrieve installed packages
	 * info. If FALSE only current project's symbols will be searched.
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @error: Error propagation and reporting.
	 * @deprecated This function is deprecated and should not be used in new code.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 *
	 * Returns: an iteratable object, or NULL if error occurs or if no symbols are found.
	 *
	 */
	public abstract Iterable? search (SymbolType match_types, bool include_types, SymbolField info_fields, string match_name, bool partial_name_match, SymbolManagerSearchFileScope filescope_search, bool global_tags_search, int results_limit, int results_offset) throws Error;

	/**
	 * ianjuta_symbol_manager_search_system:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @filescope_search: if #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC it will search only for public/extern functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE it will search also for static/private functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE it'll search for both public and private
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched in global (system) packages.
	 * User must have installed the -dev packages of, for istance, gtk+, glib, etc.
	 *
	 * Returns: an iteratable object, or NULL if error occurs or if no symbols are found.
	 *
	 */
	public abstract Iterable? search_system (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, SymbolManagerSearchFileScope filescope_search, int results_limit, int results_offset) throws Error;

	/**
	 * ianjuta_symbol_manager_search_project_async:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @filescope_search: if #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC it will search only for public/extern functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE it will search also for static/private functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE it'll search for both public and private
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @cancel: An optional #GCancellable object to cancel the operation, or NULL.
	 * @notify: #AnjutaAsyncNotify object for finish notification and error reporting.
	 * @callback: #SearchCallback callback to call when query result data from database is available
	 * @callback_user_data: User data passed to callback
	 * @error: Error propagation and reporting.
	 *
	 * Async database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched in the global packages (system) context.
	 *
	 * Returns: guint handle to identify the query result. It would infact be possible to have
	 * more async queries at the same time. This is for identify them. Returns 0 on error.
	 *
	 */
	public abstract uint search_system_async (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, SymbolManagerSearchFileScope filescope_search, int results_limit, int results_offset, Cancellable? cancel, Anjuta.AsyncNotify notify, SearchCallback callback) throws Error;

	/**
	 * ianjuta_symbol_manager_search_project:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @filescope_search: if #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC it will search only for public/extern functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE it will search also for static/private functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE it'll search for both public and private
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched in current opened project.
	 *
	 * Returns: an iteratable object, or NULL if error occurs or if no symbols are found.
	 *
	 */
	public abstract Iterable? search_project (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, SymbolManagerSearchFileScope filescope_search, int results_limit, int results_offset) throws Error;

	/**
	 * ianjuta_symbol_manager_search_project_async:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @filescope_search: if #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PUBLIC it will search only for public/extern functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_PRIVATE it will search also for static/private functions.
	 * 						If #IANJUTA_SYMBOL_MANAGER_SEARCH_FS_IGNORE it'll search for both public and private
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @cancel: An optional #GCancellable object to cancel the operation, or NULL.
	 * @notify: #AnjutaAsyncNotify object for finish notification and error reporting.
	 * @callback: #SearchCallback callback to call when query result data from database is available
	 * @callback_user_data: User data passed to callback
	 * @error: Error propagation and reporting.
	 *
	 * Async database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched only in the opened project's context.
	 *
	 * Returns: guint handle to identify the query result. It would infact be possible to have
	 * more async queries at the same time. This is for identify them. Returns 0 on error.
	 *
	 */
	public abstract uint search_project_async (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, SymbolManagerSearchFileScope filescope_search, int results_limit, int results_offset, Cancellable? cancel, Anjuta.AsyncNotify notify, SearchCallback callback) throws Error;

	/**
	 * ianjuta_symbol_manager_search_file:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @file GFile of the file, belonging to the project, which you want to scan symbols for.
	 *       Note that if the file doesn't belong to the project, it won't be scanned correctly.
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched only in the specified file.
	 * There won't be distinction in symbols with file_scope = 1 or 0
	 *
	 * Returns: an iteratable object, or NULL if error occurs or if no symbols are found.
	 *
	 */
	public abstract Iterable? search_file (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, GLib.File file, int results_limit, int results_offset) throws Error;

	/**
	 * ianjuta_symbol_manager_search_file_async:
	 * @self: Self
	 * @match_types: If passed #IANJUTA_SYMBOL_TYPE_UNDEF the function will not perfom any filter.
	 * @include_types: Should the result contain or exclude the match_types? TRUE to include them,
	 *				  FALSE to exclude. For example use may want all symbols but classes.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @pattern Pattern you want to search for. It can me something like 'foo_func' (exact match)
	 *          or something like 'foo_fun%' (LIKE match, matching all the symbol prefixed with
	 *          'foo_fun'). NULL _is not_ accepted
	 * @file GFile of the file, belonging to the project, which you want to scan symbols for.
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @cancel: An optional #GCancellable object to cancel the operation, or NULL.
	 * @notify: #AnjutaAsyncNotify object for finish notification and error reporting.
	 * @callback: #SearchCallback callback to call when query result data from database is available
	 * @callback_user_data: User data passed to callback
	 * @error: Error propagation and reporting.
	 *
	 * Async database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The search is case sensitive. Symbols are searched only in the specified file.
	 * There won't be distinction in symbols with file_scope = 1 or 0
	 *
	 * Returns: guint handle to identify the query result. It would infact be possible to have
	 * more async queries at the same time. This is for identify them. Returns 0 on error.
	 *
	 */
	public abstract uint search_file_async (SymbolType match_types, bool include_types, SymbolField info_fields, string pattern, GLib.File file, int results_limit, int results_offset, Cancellable? cancel, Anjuta.AsyncNotify notify, SearchCallback callback) throws Error;

	/**
	 * IAnjutaSymbolManagerSearchCallback:
	 * @search_id: id that identifies uniquely the async query.
	 * @result: #IAnjutaIterable iterator object that contains the database query result.
	 * @user_data: User data
	 *
	 * Callback called for an async query to the database.
	 */
	public delegate void SearchCallback (uint search_id, Iterable result);

	/**
	 * ianjuta_symbol_manager_get_members:
	 * @self: Self
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 *
	 * Returns: an iteratable object, or NULL if error occurs or if no symbols are found.
	 *
	 */
	public abstract Iterable? get_members (Symbol symbol, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_parents:
	 * @self: Self
	 * @symbol: Symbol which you want to know the parent classes of.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * The query is performed in the project db.
	 *
	 * Returns: if the passed symbol is a class then this function tries to catch its parents.
	 *
	 */
	public abstract Iterable get_class_parents (Symbol symbol, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_scope:
	 * @self: Self
	 * @filename: full path of the file.
	 * @line line of @filename in which symbol exist.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * It gets the scope specified by the line of the file.
	 *
	 * Returns: The returned iterator should contain just one element if the query is successful,
	 * no element or NULL is returned if function went wrong.
	 *
	 */
	public abstract Iterable get_scope (string filename, ulong line, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_parent_scope:
	 * @self: Self
	 * @symbol: Symbol which you want to know the parent scope of.
	 * @filename: Can be NULL. Full path filename where to search for the parent scope symbol.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * Find the parent scope given a symbol. The query is performed in the project db.
	 *
	 * Returns: The returned #IAnjutaIterable object should contain just one element if the
	 * query is successful, no element or NULL is returned if function went wrong.
	 * The returned #IAnjutaIterable object must be unreffed after use.
	 */
	public abstract Iterable get_parent_scope (Symbol symbol, string? filename, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_scope_chain:
	 * @self: Self
	 * @filename: Full path filename where to search for the parent scope symbol.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
 	 * Walk the path up to the root scope given a full_local_file_path and a line number.
 	 * The returned iterator will be populated with IAnjutaSymbol(s)
 	 * so that it could be easily browsed by a client app.
 	 * e.g.
 	 * namespace FooBase {
	 * class FooKlass {
 	 *
 	 * }
 	 *
 	 * void FooKlass::foo_func () {			<-------------- this is the scoped symbol
	 *
 	 * }
 	 *
	 * Returns: NULL on error or if scope isn't found. The returned iterator'll contain
	 * symbols in this order: foo_func, FooKlass, FooBase.
	 */
	public abstract Iterable get_scope_chain (string filename, ulong line, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_search_symbol_in_scope:
	 * @self: Self
	 * @pattern: Pattern you want to search for. If NULL it will use '%' and LIKE for query.
 	 * @container_symbol_id: The container symbol id where you want to search in.
 	 * @match_types: Can be set to IANJUTA_SYMBOL_TYPE_UNDEF. In that case these filters will not be taken into consideration.
	 * @include_kinds: Should the filter_kinds (if not null) be applied as inluded or excluded?
	 * @results_limit: Limit results to an upper bound. -1 If you don't want to use this par.
	 * @results_offset: Skip results_offset results. -1 If you don't want to use this par.
	 * @info_fields: Infos about symbols you want to know.
	 *
	 * Usually, for instance in a completion engine we have to search for symbols
	 * that are part of a container symbol, even for their existence.
	 * This function would be useful and fast in those cases.
	 */
	public abstract Iterable search_symbol_in_scope (string pattern, Symbol container_symbol, SymbolType match_types, bool include_types, int results_limit, int results_offset, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_symbol_more_info:
	 * @self: Self
	 * @symbol symbol of which you want to know more infos about.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @error: Error propagation and reporting.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * While at first sight this function may seem as useless, in a deeper inspection
	 * you can see that you can achieve speed improvements for example avoiding
	 * to pass many info_fields requests to a search query, which itself could require
	 * complicated joins between the db tables, slowing down the thing.
	 * It's up to you to see which method is more performant.
	 *
	 * Returns: The returned #IAnjutaIterable object should contain just one element if the
	 * query is successful, no element or NULL is returned if function went wrong.
	 * The returned #IAnjutaIterable object must be unreffed after use.
	 *
	 */
	public abstract Iterable get_symbol_more_info (Symbol symbol, SymbolField info_fields) throws Error;

	/**
	 * ianjuta_symbol_manager_get_symbol_by_id:
	 * @self: Self
	 * @symbol_id unique id of the symbol you want to know about.
	 * @info_fields: Kind of infos you would like to have available on the resulting Symbols.
	 * @return NULL on error.
	 *
	 * Database query. The returned #IAnjutaIterable object must be unreffed after use.
	 * A symbol is identified by an unique id. If you have its id you can also
	 * have its object IAnjutaSymbol.
	 *
	 * Returns: The returned #IAnjutaIterable object should contain just one element if the
	 * query is successful, no element or NULL is returned if function went wrong.
	 * The returned #IAnjutaIterable object must be unreffed after use.
	 */
	public abstract Symbol get_symbol_by_id (int symbol_id, SymbolField info_fields) throws Error;
}
