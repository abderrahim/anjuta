/**
 * SECTION:ianjuta-stream
 * @title: IAnjutaStream
 * @short_description: Implemented by plugins that can open file streams
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Stream : Object
{
	/**
	 * ianjuta_stream_open:
	 * @self: Self
	 * @stream: Stream to open from.
	 * @error: Error propagation and reporting
	 *
	 * The implementor opens the given stream.
	 */
	public abstract void open (FileStream stream) throws Error;
}
