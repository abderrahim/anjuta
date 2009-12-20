/**
 * SECTION:ianjuta-debugger-instruction
 * @title: IAnjutaDebuggerInstruction
 * @short_description: Debugger interface for machine instruction
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * This interface is used to debuger as machine instruction level.
 */

public struct IAnjuta.DebuggerInstructionALine
{
	public ulong address;
	public unowned string label;
	public unowned string text;
}

public struct IAnjuta.DebuggerInstructionDisassembly
{
  public uint size;
  [CCode (array_length=false)]
  public DebuggerInstructionALine data[];
}

public interface IAnjuta.DebuggerInstruction : Debugger
{
	/**
	 * ianjuta_debugger_instruction_disassemble:
	 * @self: Self
	 * @address: Start address of the memory block
	 * @length: Length of memory block
	 * @callback: Call back with a IAnjutaDebuggerInstructionDisassembly as argument
	 * @user_data: User data that is passed back to the callback
	 * @error: Error propagation and reporting.
	 *
	 * Disassemble a part of the memory
	 *
	 * Returns: TRUE if the request succeed and the callback is
	 * called. If FALSE, the callback will not be called.
	 */
	public abstract bool disassemble (ulong address, uint length, DebuggerCallback callback) throws Error;

	/**
	 * ianjuta_debugger_instruction_step_in_instruction:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Execute one assembler instruction in the program.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool step_in_instruction () throws Error;

	/**
	 * ianjuta_debugger_instruction_step_over_instruction:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Execute one assembler instruction in the program, if the instruction
	 * is a function call, continues until the function returns.
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool step_over_instruction () throws Error;

	/**
	 * ianjuta_debugger_instruction_run_to_address:
	 * @self: Self
	 * @address: Run to this addresss
	 * @error: Error propagation and reporting.
	 *
	 * Start the program until it reachs the address address
	 *
	 * Returns: TRUE if the request succeed and the callback is called. If
	 * FALSE, the callback will not be called.
	 */
	public abstract bool run_to_address (ulong address) throws Error;
}
