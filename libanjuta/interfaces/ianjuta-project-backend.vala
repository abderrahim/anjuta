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
	/*FIXME */
	public abstract Gbf.Project new_project () throws Error;
}
