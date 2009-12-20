/**
 * SECTION:ianjuta-todo
 * @title: IAnjutaTodo
 * @short_description: Task manager interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Todo : Object
{
	/**
	 * ianjuta_to_do_load:
	 * @self: Self
	 * @file: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void load(GLib.File file) throws Error;
}
