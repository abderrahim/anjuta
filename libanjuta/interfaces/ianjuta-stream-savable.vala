/**
 * SECTION:ianjuta-stream-savable
 * @title: IAnjutaStreamSavable
 * @short_description: Implemented by plugins that can save file streams
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.StreamSavable : IAnjuta.Stream
{
	/**
	 * ianjuta_stream_save:
	 * @self: Self
	 * @stream: Stream to save to.
	 * @error: Error propagation and reporting
	 *
	 * The implementor saves the content to the given stream.
	 */
	public abstract void save (FileStream stream) throws Error;
}
