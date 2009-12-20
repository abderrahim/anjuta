/**
 * SECTION:ianjuta-debugger-variable
 * @title: IAnjutaDebuggerVariable
 * @short_description: Variables interface for debuggers
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is used to examine and change values of expression.
 * It is based on the MI2 variable object interface of gdb. A
 * variable needs to be created before being able to get or set its
 * value and list its children.
 */

public struct IAnjuta.DebuggerVariableObject
{
	public string name;
	public string expression;
	public string type;
	public string value;
	public bool changed;
	public bool exited;
	public bool deleted;
	public int children;
}

public interface IAnjuta.DebuggerVariable : Debugger
{
	/**
	 * ianjuta_debugger_variable_create:
	 * @self: Self
	 * @expression: Variable expression
	 * @callback: Callback to call when the variable has been created
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Create a new variable object in the current thread and frame.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool create (string expression, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_variable_list_children:
	 * @self: Self
	 * @name: Variable name
	 * @callback: Callback to call when the children have been
	 * created
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * List and create objects for all children of a
	 * variable object.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool list_children (string name, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_variable_evaluate:
	 * @self: Self
	 * @name: Variable name
	 * @callback: Callback to call with the variable value
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Get the value of one variable or child object.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool evaluate (string name, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_variable_assign:
	 * @self: Self
	 * @name: Variable name
	 * @value: Variable value
	 * @error: Error propagation and reporting.
	 *
	 * Set the value of one variable or child object.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool assign (string name, string value) throws Error;

	/**
	 * ianjuta_debugger_variable_update:
	 * @self: Self
	 * @callback: Callback to call with the list of all changed
	 * variables
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * List all changed variable objects since the last call.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool update (DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_variable_destroy:
	 * @self: Self
	 * @name: Variable name
	 * @error: Error propagation and reporting.
	 *
	 * Delete a previously created variable or child object
	 * including its own children.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool destroy (string name) throws Error;
}
