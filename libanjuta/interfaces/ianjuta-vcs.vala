
/**
 * SECTION:ianjuta-vcs
 * @title: IAnjutaVcs
 * @short_description: Version control system interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaVcsError:
 * @IANJUTA_VCS_UNKNOWN_ERROR: Unkown error
 *
 * This enumeration is used to specify errors.
 */
public errordomain IAnjuta.VcsError
{
	UNKOWN_ERROR
}

public interface IAnjuta.Vcs : Object
{
	/**
	 * ianjuta_vcs_add:
	 * @self: Self
	 * @files: List of List of files, represented as #Gfile objects, to add
	 * @notify: #AnjutaAsyncNotify object for finish notification and error
	 * reporting.
	 *
	 * Add files to the VCS repository.
	 */
	public abstract void add(List<GLib.File> files, Anjuta.AsyncNotify notify) throws Error;

	/**
	 * ianjuta_vcs_remove:
	 * @self: Self
	 * @files: List of files, represented as #Gfile objects, to remove
	 * @notify: #AnjutaAsyncNotify object for finish notification and error
	 * reporting.
	 *
	 * Remove files from the VCS repository.
	 */
	public abstract void remove(List<GLib.File> files, Anjuta.AsyncNotify notify) throws Error;

	/**
	 * ianjuta_vcs_checkout:
	 * @self: Self
	 * @repository_location: Location of repository to check out
	 * @dest: Destination of checked out copy
	 * @cancel: An optional #GCancellable object to cancel the operation, or NULL
	 * @notify: #AnjutaAsyncNotify object for finish notification and error
	 * reporting.
	 *
	 * Check out a copy of a code repository.
	 */
	public abstract void checkout(string repository_location, GLib.File dest, Cancellable? cancel, Anjuta.AsyncNotify notify) throws Error;

    /**
	 * ianjuta_vcs_query_status:
	 * @self: Self
	 * @file: File/directory to query
	 * @callback: callback to call when data for a particular file is available
	 * @user_data: User data passed to callback
	 * @cancel: An optional #GCancellable object to cancel the operation, or NULL
	 * @notify: #AnjutaAsyncNotify object for finish notification and error
	 * reporting.
	 *
	 * Querys the status of files in the repository.
	 */
	public abstract void query_status (GLib.File file, StatusCallback callback, Cancellable? cancel, Anjuta.AsyncNotify notify) throws Error;

    /**
     * IAnjutaVcsStatusCallback:
     * @file: File representing the file for which status is given
     * @status: #AnjutaVcsStatus for the file represented by @file.
     * @user_data: User data
     *
     * Callback called for each status record returned by
     * ianjuta_vcs_query_status.
     */
	public delegate void StatusCallback (GLib.File file, Anjuta.VcsStatus status);

    /**
     * ianjuta_vcs_diff:
     * @self: Self
     * @file: File to diff
     * @callback: Callback to call when diff data becomes available
     * @user_data: User data passed to @callback
     * @cancel: An optional #GCancellable object to cancel the operation, or NULL
     * @notify: #AnjutaAsyncNotify object for finish notification and error
	 * reporting.
     *
     * Generates a unified diff of the file represented by @file.
     */
	public abstract void diff(GLib.File file, DiffCallback callback, Cancellable? cancel, Anjuta.AsyncNotify notify) throws Error;

    /**
     * IAnjutaVcsDiffCallback:
     * @file: File being diffed
     * @diff: Diff data
     * @user_data: User data
     *
     * Called when diff data comes from ianjuta_vcs_diff.
     */
	public delegate void DiffCallback (GLib.File file, string diff);
}
