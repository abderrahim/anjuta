/**
 * SECTION:ianjuta-preferences
 * @title: IAnjutaPreferences
 * @short_description: Preferences interface
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/ianjuta-preferences
 *
 */
public interface IAnjuta.Preferences : Object
{
	/**
	 * ianjuta_preferences_merge:
	 * @self: Self
	 * @prefs: AnjutaPreferences to install to
	 * @error: Error propagation and reporting.
	 *
	 * When called, the plugin should install it's preferences
	 */
	public abstract void merge(Anjuta.Preferences prefs) throws Error;

	/**
	 * ianjuta_preferences_unmerge:
	 * @self: Self
	 * @prefs: AnjutaPreferences to install to
	 * @error: Error propagation and reporting.
	 *
	 * When called, the plugin should uninstall it's preferences
	 */
	public abstract void unmerge(Anjuta.Preferences prefs) throws Error;
}
