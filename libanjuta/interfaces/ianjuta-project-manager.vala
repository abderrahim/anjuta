/**
 * SECTION:ianjuta-project-manager
 * @title: IAnjutaProjectManager
 * @short_description: Interface for project managers
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
[CCode (cprefix="IANJUTA_PROJECT_MANAGER_")]
public enum IAnjuta.ProjectManagerElementType
{
	UNKNOWN,
	SOURCE,
	TARGET,
	GROUP
}

[CCode (cprefix="IANJUTA_PROJECT_MANAGER_TARGET_")]
public enum IAnjuta.ProjectManagerTargetType
{
	UNKNOWN,
	SHAREDLIB,
	STATICLIB,
	EXECUTABLE
}

[Flags]
[CCode (cprefix="IANJUTA_PROJECT_MANAGER_")]
public enum IAnjuta.ProjectManagerCapabilities
{
	CAN_ADD_NONE     = 0,
	CAN_ADD_GROUP    = 1 << 0,
	CAN_ADD_TARGET   = 1 << 1,
	CAN_ADD_SOURCE   = 1 << 2
}


public interface IAnjuta.ProjectManager : Object
{
	/**
	 * IANJUTA_PROJECT_MANAGER_PROJECT_ROOT_URI
	 *
	 * Anjuta shell value set by project manager to the project root uri.
	 */
	public const string PROJECT_ROOT_URI = "project_root_uri";

	/**
	 * IANJUTA_PROJECT_MANAGER_CURRENT_URI
	 *
	 * Anjuta shell value set by project manager to the current uri.
	 */
	public const string CURRENT_URI = "project_manager_current_uri";

	/**
	 * IAnjutaProjectManager::element_added:
	 * @self: Self
	 * @element_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public virtual signal void element_added (string element_uri);

	/**
	 * IAnjutaProjectManager::element_removed:
	 * @self: Self
	 * @element_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public virtual signal void element_removed (string element_uri);

	/**
	 * IAnjutaProjectManager::element_selected:
	 * @self: Self
	 * @element_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public virtual signal void element_selected (string element_uri);

	// Methods

	/**
	* ianjuta_project_manager_get_element_type:
	* @self: Self
	* @element_uri: fixme
	* @error: Error propagation and reporting.
	*
	* fixme
	*
	* Returns: fixme
	*/
	public abstract ProjectManagerElementType get_element_type (string element_uri) throws Error;

	/**
	 * ianjuta_project_manager_get_elements:
	 * @self: Self
	 * @element_type: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract List<string> get_elements (ProjectManagerElementType element_type) throws Error;

	/**
	 * ianjuta_project_manager_get_target_type:
	 * @self: Self
	 * @target_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract ProjectManagerTargetType get_target_type (string target_uri) throws Error;

	/**
	 * ianjuta_project_manager_get_targets:
	 * @self: Self
	 * @target_type: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract List<string> get_targets (ProjectManagerTargetType target_type) throws Error;

	/**
	 * ianjuta_project_manager_get_parent:
	 * @self: Self
	 * @element_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract string get_parent (string element_uri) throws Error;

	/**
	 * ianjuta_project_manager_get_children:
	 * @self: Self
	 * @element_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract List<string> get_children (string element_uri) throws Error;

	/**
	 * ianjuta_project_manager_get_selected:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract string get_selected () throws Error;

	/**
	 * ianjuta_project_manager_get_selected:
	 * @self: Self
	 * @element_type: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract string get_selected_id (ProjectManagerElementType element_type) throws Error;

	/**
	 * ianjuta_project_manager_get_capabilities:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns the capabilites of project whether it can add group, target
	 * sources etc.
	 *
	 * Returns: Supported capabilites.
	 */
	public abstract ProjectManagerCapabilities get_capabilities () throws Error;

	/**
	 * ianjuta_project_manager_add_source:
	 * @self: Self
	 * @source_uri_to_add: Target name or uri
	 * @default_location_uri: Default source location or NULL if don't care
	 * @error: Error propagation and reporting.
	 *
	 * Prompt the user to add a file to the project. If the user selects
	 * multiple files only the first uri is returned.
	 *
	 * Returns: element URIs. Must be freed when no longer required.
	 */
	public abstract string add_source (string source_uri_to_add, string? default_location_uri) throws Error;

	/**
	 * ianjuta_project_manager_add_source_quiet:
	 * @self: Self
	 * @source_uri_to_add: fixme
	 * @target_id: fixme
	 * @error: Error propagation and reporting.
	 *
	 * Add a file to the project without prompting the user.
	 *
	 * Returns: element ID. Must be freed when no longer required.
	 */
	public abstract string add_source_quiet (string source_uri_to_add, string target_id) throws Error;

	/**
	 * ianjuta_project_manager_add_sources:
	 * @self: Self
	 * @source_uris_to_add: fixme
	 * @default_location_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * Prompt the user to add a file to the project. If the user selects
	 * multiple files only the first uri is returned.
	 *
	 * Returns: element URIs. Must be freed when no longer required.
	 */
	public abstract List<string> add_sources (List<string> source_uris_to_add, string default_location_uri) throws Error;

	/**
	 * ianjuta_project_manager_add_target:
	 * @self: Self
	 * @target_name_to_add: fixme
	 * @default_location_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns:
	 */
	public abstract string add_target (string target_name_to_add, string default_location_uri) throws Error;

	/**
	 * ianjuta_project_manager_add_group:
	 * @self: Self
	 * @group_name_to_add: fixme
	 * @default_location_uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 *
	 * Returns: fixme
	 */
	public abstract string add_group (string group_name_to_add, string default_location_uri) throws Error;

	/**
	 * ianjuta_project_manager_is_open:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract bool is_open () throws Error;

	/*
	 * ianjuta_project_manager_get_packages
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns: the list of pkg-config packages that the current project
	 * requires in it's configure.ac. Can be NULL if there is no project
	 * opened currently or no package is required.
	 */
	public abstract List<string> get_packages() throws Error;
}
