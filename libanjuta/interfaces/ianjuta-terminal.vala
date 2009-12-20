/**
 * SECTION:ianjuta-terminal
 * @title: IAnjutaTerminal
 * @short_description: Interface for command line terminals
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Terminal
{
	/**
	 * IAnjutaTerminal::child_exited:
	 * @self: Self
	 * @pid: pid of terminated child
	 * @status: status of terminated child as returned by waitpid
	 *
	 * This signal is emitted when a child exit.
	 */
	public virtual signal void child_exited (int pid, int status);


	/**
	 * ianjuta_terminal_execute_command:
	 * @self: Self
	 * @directory: Working directory
	 * @command: Command executed followed by arguments
	 * @environment: List of additional environment variables
	 * @error: Error propagation and reporting.
	 *
	 * Run the command in a terminal, setting the working directory
	 * and environment variables.
	 *
	 * Returns: Process ID
	 */
	public abstract Posix.pid_t execute_command (string directory, string command, [CCode (array_length=false, array_null_terminated=true)] string[] environment) throws Error;
}
