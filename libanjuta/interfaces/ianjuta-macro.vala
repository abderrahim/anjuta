/**
 * SECTION:ianjuta-macro
 * @title: IAnjutaMacro
 * @short_description: Macro processor interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Macro : Object
{
	/**
	 * ianjuta_macro_insert:
	 * @key: Key of the macro
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Insert Macro to editor
	 */
	public abstract void insert(string key) throws Error;
}
