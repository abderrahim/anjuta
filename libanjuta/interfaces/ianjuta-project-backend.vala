/**
 * SECTION:ianjuta-project-backend
 * @title: IAnjutaProjectBackend
 * @short_description: Interface for creating new project
 * @see_also:
 * @stability: Unstable
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */
public interface IAnjuta.ProjectBackend : Object
{
	/**
	 * ianjuta_project_backend_new_project:
	 * @self: Self
	 * @error: Error propagation and reporting
	 *
	 * Get a new GbfProject
	 *
	 * Return value: An object derived from GbfProject
	 */
	public abstract Project new_project () throws Error;

	/**
	 * ianjuta_project_backend_probe:
	 * @self: Self
	 * @directory: Project directory
	 * @error: Error propagation and reporting
	 *
	 * Check if the directory contains a project supported by this
	 * backend
	 *
	 * Return value: 0 if the project is invalid and > 0 if the
	 * project is valid. 
	 */
	public abstract int probe (GLib.File directory) throws Error;
}
