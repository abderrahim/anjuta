/**
 * SECTION:ianjuta-print
 * @title: IAnjutaPrint
 * @short_description: Print interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Print : Object
{
	/**
	 * ianjuta_print_print:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Print the plugin (the file in case of the editor). In most cases this will show
	 * a print dialog
	 */
	public abstract void print() throws Error;

	/**
	 * ianjuta_print_print:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Show print preview dialog
	 */
	public abstract void print_preview() throws Error;
}
