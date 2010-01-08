/**
 * SECTION:ianjuta-debugger-memory
 * @title: IAnjutaDebuggerMemory
 * @short_description: Memory interface for debuggers
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is used to examine the target memory.
 */

public struct IAnjuta.DebuggerMemoryBlock
{
	public ulong address;
	public uint length;
	public string data;
}

public interface IAnjuta.DebuggerMemory : Debugger
{
	/**
	 * ianjuta_debugger_memory_inspect:
	 * @self: Self
	 * @address: Start address of the memory block
	 * @length: Length of memory block
	 * @callback: Call back with a IAnjutaDebuggerMemoryBlock as argument
	 * @callback_target: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Read a block of the target memory.
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool inspect (ulong address, uint length, DebuggerCallback callback) throws Error;
}
