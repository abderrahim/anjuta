/**
 * SECTION:ianjuta-wizard
 * @title: IAnjutaWizard
 * @short_description: Interface for wizards that can create new stuffs
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.Wizard : Object
{

	/**
	 * ianjuta_wizard_activate:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Called when the wizard should start after some user action
	 */
	public abstract void activate() throws Error;
}
