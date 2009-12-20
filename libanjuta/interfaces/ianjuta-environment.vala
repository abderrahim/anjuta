/**
 * SECTION:ianjuta-environment
 * @title: IAnjutaEnvironment
 * @short_description: Implemented by plugins doing cross compilation
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Environment : Object
{
	/**
	 * ianjuta_environment_override:
	 * @self: Self
	 * @dirp: a pointer on the working directory
	 * @argvp: a pointer on a NULL terminated string array
	 *     containing the command name in argv[0] and all
	 *    its argument
	 * @envp: a pointer on a NULL terminated string array
	 *    containing all additional environment variable
	 *    used by the command
	 * @error: Error propagation and reporting.
	 *
	 * Override a command to work in another build environment
	 *
	 * Returns: FALSE if there is an error.
	 */
	public abstract bool @override (ref string dirp,
									[CCode (array_length=false, array_null_terminated=true)]
									ref string[] argvp,
									[CCode (array_length=false, array_null_terminated=true)]
									ref string[] envp) throws Error;

	/**
	 * ianjuta_environment_get_real_directory:
	 * @self: Self
	 * @dir: A directory path in the environment
	 * @error: Error propagation and reporting.
	 *
	 * Convert a directory in the environment to a directory outside.
	 * It is useful when the environment use chroot. Take care that
	 * the input directory string is freed using g_free but and you need to
	 * free the output string when not needed.
	 *
	 * Returns: The directory path outside the environment
	 */
	public abstract string get_real_directory (string dir) throws Error;
}
