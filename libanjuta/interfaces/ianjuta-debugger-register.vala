/**
 * SECTION:ianjuta-debugger-register
 * @title: IAnjutaDebuggerRegister
 * @short_description: Register interface for debuggers
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is used to examine and change values of CPU registers.
 */

public struct IAnjuta.DebuggerRegisterData
{
	uint num;
	string name;
	string value;
}

public interface IAnjuta.DebuggerRegister : Debugger
{
	/**
	 * ianjuta_debugger_register_list_register:
	 * @self: Self
	 * @callback: Callback to call with the register list
	 * @callback_target: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * List all registers of the target. This function can be called without
	 * a program loaded, the value field of register structure is not filled.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool list_register (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_register_update_register:
	 * @self: Self
	 * @callback: Callback call with the list of all modified registers
	 * @callback_target: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Return all modified registers since the last call. Only the num and
	 * value field are used.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool update_register (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_register_write_register:
	 * @self: Self
	 * @value: Modified register with a new value
	 * @error: Error propagation and reporting.
	 *
	 * Change the value of one register. Only the num and value field are used.
	 *
	 * Returns: TRUE if the request succeed.
	 */
	public abstract bool write_register (DebuggerRegisterData value) throws Error;
}
