/**
 * SECTION:ianjuta-debugger-breakpoint
 * @title: IAnjutaDebuggerBreakpoint
 * @short_description: Breakpoint Debugger interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
[Flags]
[CCode (cprefix="IANJUTA_DEBUGGER_BREAKPOINT_")]
public enum IAnjuta.DebuggerBreakpointType
{
	REMOVED = 1 << 0,
	UPDATED = 1 << 17,
	ON_LINE = 1 << 1,
	ON_ADDRESS = 1 << 2,
	ON_FUNCTION = 1 << 3,
	ON_READ = 1 << 4,
	ON_WRITE = 1 << 5,
	WITH_ENABLE = 1 << 16,
	WITH_IGNORE = 1 << 15,
	WITH_TIME = 1 << 11,
	WITH_CONDITION = 1 << 12,
	WITH_TEMPORARY = 1 << 13
}

public struct IAnjuta.DebuggerBreakpointItem
{
	int type;
	uint id;
	string file;
	uint line;
	string function;
	ulong address;
	bool enable;
	uint ignore;
	uint times;
	string condition;
	bool temporary;
}

[Flags]
[CCode (cprefix="IANJUTA_DEBUGGER_BREAKPOINT_")]
public enum IAnjuta.DebuggerBreakpointMethod
{
	SET_AT_ADDRESS = 1 << 0,
	SET_AT_FUNCTION = 1 << 1,
	ENABLE = 1 << 2,
	IGNORE = 1 << 3,
	CONDITION = 1 << 4
}

public interface IAnjuta.DebuggerBreakpoint : Debugger
{

	/**
	 * ianjuta_debugger_breakpoint_implement_breakpoint:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Return all implemented methods.
	 *
	 * Returns: A OR of IAnjutaDebuggerBreakpointMethod
	 * corresponding to all implemented optional methods.
	 */
	public abstract int implement_breakpoint () throws Error;

	/**
	 * ianjuta_debugger_breakpoint_set_breakpoint_at_line:
	 * @self: Self
	 * @file: File containing the breakpoint
	 * @line: Line number where is the breakpoint
	 * @callback: Callback to call when the breakpoint has been set
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Set a breakpoint at the specified line in the file.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool set_breakpoint_at_line (string  file, uint line, DebuggerCallback callback) throws Error;


	/**
	 * ianjuta_debugger_breakpoint_set_breakpoint_at_address:
	 * @self: Self
	 * @address: Address of the breakpoint
	 * @callback: Callback to call when the breakpoint has been set
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Set a breakpoint at the specified address.
	 * This function is optional.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool set_breakpoint_at_address (ulong address, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_set_breakpoint_at_function:
	 * @self: Self
	 * @file: File containing the breakpoint
	 * @function: Function name where the breakpoint is put
	 * @callback: Callback to call when the breakpoint has been set
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Set a breakpoint at the beginning of the specified function.
	 * This function is optional.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool set_breakpoint_at_function (string file, string function, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_clear_breakpoint:
	 * @self: Self
	 * @id: Breakpoint identification number
	 * @callback: Callback to call when the breakpoint has been cleared
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Clear a breakpoint put by any set functions. The Id of the breakpoint
	 * is given in the callback of the set functions.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool clear_breakpoint (uint id, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_list_breakpoint:
	 * @self: Self
	 * @callback: Callback to call with the list of breakpoints
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * List all breakpoints set in the debugger. It is useful to
	 * know how many time a breakpoint has been hit.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool list_breakpoint (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_enable_breakpoint:
	 * @self: Self
	 * @id: Breakpoint identification number
	 * @enable: TRUE to enable the breakpoint, FALSE to disable it
	 * @callback: Callback to call when the breakpoint has been changed
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Enable of disable a breakpoint. This function is optional.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool enable_breakpoint (uint id, bool enable, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_ignore_breakpoint:
	 * @self: Self
	 * @id: Breakpoint identification number
	 * @ignore: Number of time a breakpoint must be ignored
	 * @callback: Callback to call when the breakpoint has been changed
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * This allow to ignore the breakpoint a number of time before stopping.
	 * This function is optional.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool ignore_breakpoint (uint id, uint ignore, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_breakpoint_condition_breakpoint:
	 * @self: Self
	 * @id: Breakpoint identification number
	 * @condition: expression that has to be true
	 * @callback: Callback to call when the breakpoint has been changed
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Add a condition, evaluate in the program context, on the breakpoint,
	 * the program will stop when it reachs the breakpoint only if the
	 * condition is true. This function is optional.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool condition_breakpoint (uint id, string condition, DebuggerCallback callback) throws Error;
}
