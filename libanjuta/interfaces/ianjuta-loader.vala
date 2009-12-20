/**
 * SECTION:ianjuta-loader
 * @title: IAnjutaLoader
 * @short_description: Interface to load file or stream
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * Loaders can deterime correct plugin to open a file or stream.  They
 * themselves can not load it, but will correctly redirect the request to
 * an implementor of IAnjutaFile, IAnjutaFileSavable, IAnjutaStream or
 * IAnjutaStreamSavable, depending on the mime-type, meta-type or any other
 * requirements.
 */
public interface IAnjuta.Loader : Object
{
	/**
	 * ianjuta_loader_find_plugins:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Returns: all plugins supporting loader interface.
	 */
	/*FIXME */
	public abstract List<Anjuta.Plugin> find_plugins () throws Error;
}
