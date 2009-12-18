/**
 * SECTION:ianjuta-debugger
 * @title: IAnjutaDebugger
 * @short_description: Debugger interface
 * @see_also: #IAnjutaDebugManager
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is implemented by debugger backends, by example the gdb
 * backend. It is used by the debug manager plugin which provides the
 * graphical interface and a simple wrapper: #IAnjutaDebugManager.
 *
 * The debugger is in one on these 5 states and emit a signal to the debug
 * manager when it changes. Here is figure showing all transitions and
 * the signal emitted.
 * <figure id="debugger-states">
 *	<mediaobject>
 *		<imageobject>
 *			<imagedata fileref="debugger-states.png" format="PNG"/>
 *		</imageobject>
 *	</mediaobject>
 * </figure>
 *
 */

[CCode (cprefix="IANJUTA_DEBUGGER_")]
public errordomain IAnjuta.DebuggerError
{
	OK              =  0,
	NOT_READY,
	NOT_RUNNING,
	NOT_STOPPED,
	NOT_LOADED,
	NOT_STARTED,
	NOT_CONNECTED,
	NOT_IMPLEMENTED,
	CANCEL,
	UNABLE_TO_CREATE_VARIABLE,
	UNABLE_TO_ACCESS_MEMORY,
	UNABLE_TO_OPEN_FILE,
	UNSUPPORTED_FILE_TYPE,
	UNSUPPORTED_VERSION,
	UNABLE_TO_FIND_DEBUGGER,
	ALREADY_DONE,
	PROGRAM_NOT_FOUND,
	UNABLE_TO_CONNECT,
	UNKNOWN_ERROR,
	OTHER_ERROR
}

[CCode (cprefix="IANJUTA_DEBUGGER_")]
public enum IAnjuta.DebuggerData
{
	INFORMATION,
	BREAKPOINT,
	FRAME,
	VARIABLE,
	REGISTER
}

[CCode (cprefix="IANJUTA_DEBUGGER_")]
public enum IAnjuta.DebuggerOutputType
{
	OUTPUT,
	WARNING_OUTPUT,
	ERROR_OUTPUT,
	INFO_OUTPUT
}

[CCode (cprefix="IANJUTA_DEBUGGER_")]
public enum IAnjuta.DebuggerState
{
	BUSY,
	STOPPED,
	STARTED,
	PROGRAM_LOADED,
	PROGRAM_STOPPED,
	PROGRAM_RUNNING
}

public struct IAnjuta.DebuggerFrame
{
	int thread;
	uint level;
	string args;
	string file;
	uint line;
	string function;
	string library;
	ulong address;
}

/* FIXME: GError parameter */
public delegate void IAnjuta.DebuggerCallback (void* data, Error err);
public delegate void IAnjuta.DebuggerOutputCallback (DebuggerOutputType type, string output);
public delegate void IAnjuta.DebuggerMemoryCallback (ulong address, uint length, string data, Error err);

public interface IAnjuta.Debugger : Object
{
	/**
	 * IAnjutaDebugger::debugger_started:
	 * @self: Self
	 *
	 * This signal is emitted when the debugger is started.
	 */
	public signal void debugger_started ();

	/**
	 * IAnjutaDebugger::debugger_stopped:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * This signal is emitted when the debugger is stopped. The error
	 * parameters allow to check it has run correctly.
	 */
	public signal void debugger_stopped (Error err);

	/**
	 * IAnjutaDebugger::program_loaded:
	 * @self: Self
	 *
	 * This signal is emitted when a program is loaded.
	 */
	public signal void program_loaded ();

	/**
	 * IAnjutaDebugger::program_running:
	 * @self: Self
	 *
	 * This signal is emitted when the program is running.
	 */
	public signal void program_running ();

	/**
	 * IAnjutaDebugger::program_stopped:
	 * @self: Self
	 *
	 * This signal is emitted when the program is interrupted.
	 */
	public signal void program_stopped ();

	/**
	 * IAnjutaDebugger::program_exited:
	 * @self: Self
	 *
	 * This signal is emitted when the program exits.
	 */
	public signal void program_exited ();

	/**
	 * IAnjutaDebugger::sharedlib_event:
	 * @self: Self
	 *
	 * This signal is emitted when the program load a new shared
	 * library.
	 */
	public signal void sharedlib_event ();

	/**
	 * IAnjutaDebugger::program_moved:
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
	public signal void program_moved (int pid, int tid, ulong address, string? file, uint line);

	/**
	 * IAnjutaDebugger::frame_changed:
	 * @self: Self
	 * @frame: frame number
	 * @thread: thread number
	 *
	 * This signal is emitted when the current frame changes.
	 */
	public signal void frame_changed (uint frame, int thread);

	/**
	 * IAnjutaDebugger::signal_received:
	 * @self: Self
	 * @name: Signal name
	 * @description: Signal description
	 *
	 * This signal is emitted when the program received a unix signal.
	 */
	public signal void signal_received (string name, string description);

	/**
	 * IAnjutaDebugger::debugger_ready:
	 * @self: Self
	 * @state: debugger status
	 *
	 * This signal is emitted when the debugger is ready to execute
	 * a new command.
	 */
	public signal void debugger_ready (DebuggerState state);


	/**
	 * ianjuta_debugger_get_state:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Get the current state of the debugger
	 *
	 * Returns: The current debugger state.
	 */
	public abstract DebuggerState get_state () throws Error;

	/**
	 * ianjuta_debugger_load:
	 * @self: Self
	 * @file: filename
	 * @mime_type: mime type of the file
	 * @source_search_directories: List of directories to search for
	 *			      source files.
	 * @error: Error propagation and reporting.
	 *
	 * Load a program in the debugger.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool load (string file, string mime_type, List<string> source_search_directories) throws Error;

	/**
	 * ianjuta_debugger_attach:
	 * @self: Self
	 * @pid: pid of the process to debug
	 * @source_search_directories: List of directories to search for
	 *			      source files.
	 * @error: Error propagation and reporting.
	 *
	 * Attach to an already running process.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool attach (Posix.pid_t pid, List<string> source_search_directories) throws Error;

	/**
	 * ianjuta_debugger_set_working_directory:
	 * @self: Self
	 * @dir: working program directory
	 * @error: Error propagation and reporting.
	 *
	 * Set program working directory.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool set_working_directory (string dir) throws Error;

	/**
	 * ianjuta_debugger_set_environment:
	 * @self: Self
	 * @env: List environment variable
	 * @error: Error propagation and reporting
	 *
	 * Set environment variable
	 *
	 * Returns: TRUE if sucessfull, other FALSE.
	 */
	public abstract bool set_environment ([CCode (array_length=false, array_null_terminated=true)] string[] env) throws Error;

	/**
	 * ianjuta_debugger_start:
	 * @self: Self
	 * @args: command line argument of the program
	 * @terminal: TRUE if the program need a terminal
	 * @stop: TRUE if program is stopped at the beginning
	 * @error: Error propagation and reporting.
	 *
	 * Start a loaded program under debugger control.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool start (string args, bool terminal, bool stop) throws Error;

	/**
	 * ianjuta_debugger_connect:
	 * @self: Self
	 * @server: remote server
	 * @args: command line argument of the program
	 * @terminal: TRUE if the program need a terminal
	 * @stop: TRUE if program is stopped at the beginning
	 * @error: Error propagation and reporting
	 *
	 * Connect to a remote debugger and run program
	 *
	 * Returns: TRUE if sucessfull, otherwise FALSE.
	 */
	public abstract bool connect (string server, string args, bool terminal, bool stop) throws Error;

	/**
	 * ianjuta_debugger_unload:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Unload a program.
	 *
	 * Returns: TRUE if sucessfull, otherwise FALSE.
	 */
	public abstract bool unload () throws Error;

	/**
	 * ianjuta_debugger_quit:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Quit the debugger, can wait until the debugger is ready.
	 *
	 * Returns: TRUE if sucessful, other FALSE.
	 */
	public abstract bool quit () throws Error;

	/**
	 * ianjuta_debugger_abort:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Quit the debugger as fast as possible.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool abort () throws Error;

	/**
	 * ianjuta_debugger_run:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Run the program currently loaded.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool run () throws Error;

	/**
	 * ianjuta_debugger_step_in:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Execute a single C instruction of the program currently loaded.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool step_in () throws Error;

	/**
	 * ianjuta_debugger_step_over:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Execute one C instruction, without entering in procedure, of
	 * the program currently loaded.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool step_over () throws Error;

	/**
	 * ianjuta_debugger_step_out:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Execute the currently loaded program until it goes out of the
	 * current procedure.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool step_out () throws Error;

	/**
	 * ianjuta_debugger_run_to:
	 * @self: Self
	 * @file: target file name
	 * @line: target line in file
	 * @error: Error propagation and reporting.
	 *
	 * Execute the currently loaded program until it reachs the target
	 * line.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool run_to (string file, int line) throws Error;

	/**
	 * ianjuta_debugger_exit:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Exit from the currently loaded program.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool exit () throws Error;

	/**
	 * ianjuta_debugger_interrupt:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Interrupt the program currently running.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool interrupt () throws Error;

	/**
	 * ianjuta_debugger_inspect:
	 * @self: Self
	 * @name: variable name
	 * @callback: Callback to call with variable value
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get back the value of the named variable.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool inspect (string name, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_evaluate:
	 * @self: Self
	 * @name: variable name
	 * @value: new variable value
	 * @callback: Callback to call when the variable has been modified
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Change the value of a variable in the current program.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool evaluate (string name, string value, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_print:
	 * @self: Self
	 * @name: variable name
	 * @callback: Callback to call with variable value
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Display value of a variable, like inspect.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool print (string variable, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_list_local:
	 * @self: Self
	 * @callback: Callback to call with list of local variable
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the list of local variables
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool list_local (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_list_argument:
	 * @self: Self
	 * @callback: Callback to call with list of arguments
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the list of arguments
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool list_argument (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_signal:
	 * @self: Self
	 * @callback: Callback to call with list of arguments
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some informatin about a signal
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_signal (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_sharedlib:
	 * @self: Self
	 * @callback: Callback to call with list of arguments
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get information about shared libraries.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_sharedlib (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_handle_signal:
	 * @self: Self
	 * @name: signal name
	 * @stop: TRUE if we need to stop signal
	 * @print: TRUE if we display a message when the signal is emitted
	 * @ignore: TRUE if we ignore the signal
	 * @error: Error propagation and reporting.
	 *
	 * It defines how to handle signal received by the program.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool handle_signal (string name, bool stop, bool print, bool ignore) throws Error;

	/**
	 * ianjuta_debugger_info_frame:
	 * @self: Self
	 * @frame: frame number, the top frame has the number 0
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some information about the one stack frame.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_frame (uint frame, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_args:
	 * @self: Self
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some informatin about a current functin arguments.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_args (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_target:
	 * @self: Self
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get back some information about the target
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_target (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_program:
	 * @self: Self
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some informatin about a current program.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_program (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_info_udot:
	 * @self: Self
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some information about OS structures.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_udot (DebuggerCallback callback) throws Error;


	/**
	 * ianjuta_debugger_info_variables:
	 * @self: Self
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some informatin about variables.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_variables (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_list_frame:
	 * @self: Self
	 * @callback: Callback to call getting a list of frame
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the list of frames.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool list_frame (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_set_frame:
	 * @self: Self
	 * @frame: frame number
	 * @error: Error propagation and reporting.
	 *
	 * Set the current frame.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool set_frame (uint frame) throws Error;

	/**
	 * ianjuta_debugger_list_thread:
	 * @self: Self
	 * @callback: Callback to call getting a list of thread
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the list of threads.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool list_thread (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_set_thread:
	 * @self: Self
	 * @thread: thread number
	 * @error: Error propagation and reporting.
	 *
	 * Set the current thread.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool set_thread (int thread) throws Error;

	/**
	 * ianjuta_debugger_info_thread:
	 * @self: Self
	 * @thread: thread number
	 * @callback: Callback to call getting a string with all information
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get some information about current threads.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool info_thread (int thread, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_list_register:
	 * @self: Self
	 * @callback: Callback to call getting a list of registers
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the list of registers.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool list_register (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_send_command:
	 * @self: Self
	 * @command: command
	 * @error: Error propagation and reporting.
	 *
	 * Send a command directly to the debugger. Warning, changing the
	 * debugger states, by sending a run command by example, will
	 * probably gives some troubles in the debug manager.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool send_command (string command) throws Error;

	/**
	 * ianjuta_debugger_callback:
	 * @self: Self
	 * @callback: Callback to call
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * All commands are executed asynchronously and give back information
	 * with callbacks. It is difficult to know when a command is really
	 * executed. But as all commands are executed in order, you can use
	 * this command to get a call back when all previous commands have
	 * been executed.
	 *
	 * Returns: TRUE if sucessful, otherwise FALSE.
	 */
	public abstract bool callback (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_enable_log:
	 * @self: Self
	 * @log: MessageView used by log
	 * @error: Error propagation and reporting.
	 *
	 * Log all debuggers commands, mainly useful for debugging.
	 */
	public abstract void enable_log (MessageView log) throws Error;

	/**
	 * ianjuta_debugger_disable_log:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Disable debugger log.
	 */
	public abstract void disable_log () throws Error;
}
