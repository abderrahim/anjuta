/**
 * SECTION:ianjuta-indicable
 * @title: IAnjutaIndicable
 * @short_description: Implemented by indicate that indicate a range
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaIndicableIndicator:
 * @IANJUTA_INDICABLE_NONE: No indicator
 * @IANJUTA_INDICABLE_IMPORTANT: Important indicator
 * @IANJUTA_INDICABLE_WARNING: Warning indicator
 * @IANJUTA_INDICABLE_CRITICAL: Critical indicator
 *
 * This enumeration is used to specify the appearance of the indicator
 */
[CCode (cprefix="IANJUTA_INDICABLE_")]
public enum IAnjuta.IndicableIndicator
{
	NONE,
	IMPORTANT,
	WARNING,
	CRITICAL
}

public interface IAnjuta.Indicable : Object
{

	/**
	 * ianjuta_indicable_set:
	 * @self: Self
	 * @begin_location: Location where the indication should start
	 * @end_location: Location where the indication should end
	 * @indicator: the indicator to use
	 * @error: Error propagation and reporting
	 *
	 * Set an indicator
	 *
	 */
	public abstract void @set (Iterable begin_location, Iterable end_location,
							   IndicableIndicator indicator) throws Error;

	/**
	 * ianjuta_indicable_clear:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Clear all indicators
	 *
	 */
	public abstract void clear () throws Error;
}
