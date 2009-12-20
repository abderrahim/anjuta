/**
 * SECTION:ianjuta-stream-loader
 * @title: IAnjutaStreamLoader
 * @short_description: Loader to load streams
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 * StreamLoaders can deterime correct plugin to open a stream.
 */
public interface IAnjuta.StreamLoader : Loader
{
	/**
	 * ianjuta_stream_loader_load:
	 * @self: Self
	 * @stream: Stream to load
	 * @readonly: Open in readonly mode.
	 * @error: Error propagation and reporting
	 *
	 * Determines a plugin which can open the given stream, activates it
	 * opening the stream and returns the interface of the plugin activated.
	 *
	 * Return value: Plugin interface used to load the stream.
	 */
	public abstract Object load (FileStream stream, bool readonly) throws Error;

	/**
	 * ianjuta_stream_loader_peek_interface:
	 * @self: Self
	 * @stream: Stream to load
	 * @error: Error propagation and reporting
	 *
	 * Peeks the stream and determines the interface which can load
	 * this stream.
	 *
	 * Return value: Plugin interface name that can load the stream.
	 */
	public abstract string peek_interface (FileStream stream) throws Error;
}
