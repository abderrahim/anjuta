/**
 * SECTION:ianjuta-builder
 * @title: IAnjutaBuilder
 * @short_description: Implemented by plugins that can build
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

public delegate void IAnjuta.BuilderCallback (Object sender, void* command, Error err);

/**
 * IAnjutaBuilderError:
 * @IANJUTA_BUILDER_SUCCEED: Build succeeded
 * @IANJUTA_BUILDER_FAILED: Build failed
 * @IANJUTA_BUILDER_CANCELED: Build was canceld
 * @IANJUTA_BUILDER_ABORTED: Build aborted
 * @IANJUTA_BUILDER_INTERRUPTED: Build interruped
 * @IANJUTA_BUILDER_TERMINATED: Build interruped
 * @IANJUTA_BUILDER_UNKNOWN_TARGET: The specified target is unknown
 * @IANJUTA_BUILDER_UNKNOWN_ERROR: Unknown Error
 * @IANJUTA_BUILDER_OTHER_ERROR: Other Error (no unknown ;-))
 *
 * Possible build errors
 */
[CCode (cprefix="IANJUTA_BUILDER_")]
public errordomain IAnjuta.BuilderError
{
	SUCCEED           =  0,
	FAILED,
	CANCELED	= 256,
	ABORTED,
	INTERRUPTED,
	TERMINATED,
	UNKNOWN_TARGET,
	UNKNOWN_ERROR,
	OTHER_ERROR
}

public interface IAnjuta.Builder : Object
{
	/**
	 * IANJUTA_BUILDER_ROOT_URI
	 *
	 * Build directory uri. It is the same than the project_root_uri for
	 * in source build.
	 */
	public const string ROOT_URI = "build_root_uri";

	/**
	 * IANJUTA_BUILDER_CONFIGURATION_DEBUG
	 *
	 * Name of debugging configutation.
	 */
	public const string CONFIGURATION_DEBUG = "Debug";

	/**
	 * IANJUTA_BUILDER_CONFIGURATION_OPTIMIZED
	 *
	 * Name of optimized configutation.
	 */
	public const string CONFIGURATION_OPTIMIZED = "Optimized";

	/**
	 * IANJUTA_BUILDER_CONFIGURATION_PROFILING
	 *
	 * Name of profiling configutation.
	 */
	public const string CONFIGURATION_PROFILING = "Profiling";

	/**
	 * ianjuta_builder_is_built:
	 * @self: Self
	 * @uri: target uri
	 * @callback: callback called when command is finished
	 * @user_data: data passed to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Check if the corresponding target is up to date or not. This
	 * command doesn't display anything. If this command cannot be
	 * implemented, it is possible to return always TRUE.
	 * When the command is finished, the callback function is called
	 * if defined.
	 *
	 * Returns: non null command handle if succeed
	 */
	public abstract void* is_built (string uri, BuilderCallback callback) throws Error;

	/**
	 * ianjuta_builder_build:
	 * @self: Self
	 * @uri: target uri
	 * @callback: callback called when command is finished
	 * @user_data: data passed to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Build the specified target.
	 * When the command if finished, the callback function is called
	 * if defined.
	 *
	 * Returns: non null command handle if succeed
	 */
	public abstract void* build (string uri, BuilderCallback callback) throws Error;

	/**
	 * ianjuta_builder_cancel:
	 * @self: Self
	 * @handle: handle of the command to cancel
	 * @error: Error propagation and reporting.
	 *
	 * Cancel specified command. The callback function will not
	 * be called.
	 *
	 */
	public abstract void cancel (void* handle) throws Error;

	/**
	 * ianjuta_builder_list_configuration:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * List all defined configuration. These names returned are
	 * the internal non localized names for the following
	 * predefined configuration: Debug, Profiling, Optimized.
	 * The default configuration has no name and is not returned.
	 *
	 * Returns: a list configuration name. The names are owned
	 * by the plugin, so only the list has to be free using
	 * g_list_free.
	 */
	public abstract List<string> list_configuration() throws Error;

	/**
	 * ianjuta_builder_get_uri_configuration:
	 * @self: Self
	 * @uri: target uri
	 * @error: Error propagation and reporting.
	 *
	 * Get the configuration corresponding to the target uri.
	 *
	 * Returns: The configuration name or NULL if the corresponding
	 * configuration cannot be found.
	 */
	public abstract unowned string? get_uri_configuration(string uri) throws Error;
}
