/**
 * SECTION:ianjuta-debug-manager
 * @title: IAnjutaDebugManager
 * @short_description: Common graphical interface to all debugger
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface wrap the real debugger plugin and provide a
 * common graphical user interface.
 */

public interface IAnjuta.DebugManager
{
	/* Signals */

	/**
	 * IAnjutaDebugManager::debugger_started:
	 * @self: Self
	 *
	 * This signal is emitted when the debugger is started.
	 */
	public virtual signal void debugger_started ();

	/**
	* IAnjutaDebugManager::debugger_stopped:
	* @self: Self
	* @error: Error propagation and reporting.
	*
	* This signal is emitted when the debugger is stopped.
	*/
	public virtual signal void debugger_stopped (Error err);

	/**
	 * IAnjutaDebugManager::program_loaded:
	 * @self: Self
	 *
	 * This signal is emitted when a program is loaded most of the
	 * time just before the first program_stopped signal.
	 */
	public virtual signal void program_loaded ();

	/**
	 * IAnjutaDebugManager::program_unloaded:
	 * @self: Self
	 *
	 * This signal is emitted when a program is unloaded. If the
	 * debugger is stopped while a program is loaded, this signal
	 * is emitted before the debugger_stopped signal.
	 */
	public virtual signal void program_unloaded ();

	/**
	 * IAnjutaDebugManager::program_started:
	 * @self: Self
	 *
	 * This signal is emitted when the program is started. If the
	 * program starts and is stopped by the debugger, a program-stopped
	 * signal will be emitted too. If the program starts is not stopped
	 * by the debugger a program-running signal will be emitted.
	 */
	public virtual signal void program_started ();

	/**
	 * IAnjutaDebugManager::program_exited:
	 * @self: Self
	 *
	 * This signal is emitted when the program is unloaded. If the
	 * debugger is stopped while a program is running or stopped, this
	 * signal is emitted before the program_unloaded signal.
	 */
	public virtual signal void program_exited ();

	/**
	 * IAnjutaDebugManager::program_stopped:
	 * @self: Self
	 *
	 * This signal is emitted when the program is stopped.
	 */
	public virtual signal void program_stopped ();

	/**
	 * IAnjutaDebugManager::program_running:
	 * @self: Self
	 *
	 * This signal is emitted when the program is running.
	 */
	public virtual signal void program_running ();

	/**
	 * IAnjutaDebugManager::sharedlib_event:
	 * @self: Self
	 *
	 * This signal is emitted when a new shared library is loaded. It
	 * is useful to try to set pending breakpoints those could be in
	 * the newly loaded library.
	 */
	public virtual signal void sharedlib_event ();

	/**
	 * IAnjutaDebugManager::program_moved:
	 * @self: Self
	 * @pid: process id, 0 when unknown
	 * @tid: thread id, 0 when unknown
	 * @address: program counter address, 0 when unknown
	 * @file: source file where is the program counter, NULL when unknown
	 * @line: line number if file name above is not NULL
	 *
	 * This signal is emitted when the debugger know the current program
	 * location. Most of the time, after the program has stopped but it
	 * could happen even if it is still running.
	 */
	public virtual signal void program_moved (int pid, int tid, ulong address, string? file, uint line);

	/**
	 * IAnjutaDebugManager::frame_changed:
	 * @self: Self
	 * @frame: frame
	 * @thread: thread
	 *
	 * This signal is emitted when the current frame is changed. It is
	 * equal to the top frame in the interrupted thread when the
	 * program stops but can be changed afterward by the user.
	 * Several commands use this current frame, by example the register
	 * window display the register values for the current thread only.
	 */
	public virtual signal void frame_changed (uint frame, int thread);

	/**
	 * IAnjutaDebugManager::location_changed:
	 * @self: Self
	 * @address: program counter address, 0 when unknown
	 * @uri: source file where is the program counter, NULL when unknown
	 * @line: line number if file name above is not NULL
	 *
	 * This signal is emitted when the current location is changed. It is
	 * equal to the program location when the program stops but can be
	 * changed afterward by the user.
	 */
	public virtual signal void location_changed (ulong address, string? uri, uint line);

	/**
	 * IAnjutaDebugManager::signal_received:
	 * @self: Self
	 * @name: Signal name
	 * @description: Signal description
	 *
	 * This signal is emitted when the debugged program receives a
	 * unix signal.
	 */
	public virtual signal void signal_received (string name, string description);

	/**
	 * IAnjutaDebugManager::breakpoint_changed:
	 * @self: Self
	 * @breakpoint: Breakpoint
	 * @error: Error propagation and reporting.
	 *
	 * This signal is emitted when a breakpoint is changed. It includes
	 * new breakpoint and deleted breakpoint.
	 */
	public virtual signal void breakpoint_changed (DebuggerBreakpointItem breakpoint);

	/**
	 * ianjuta_debug_manager_start:
	 * @self: Self
	 * @uri: uri of the target
	 * @error: Error propagation and reporting.
	 *
	 * Start the debugger of the given uri
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool start (string uri) throws Error;

	/**
	 * ianjuta_debug_manager_start_remote:
	 * @self: Self
	 * @server: server (IP address:port)
	 * @uri: uri of the local target
	 * @error: Error propagation and reporting.
	 *
	 * Start the debugger of the given uri
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool start_remote (string server, string uri) throws Error;

	/**
	 * ianjuta_debug_manager_quit:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Quit the debugger, can wait until the debugger is ready.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool quit () throws Error;
}
