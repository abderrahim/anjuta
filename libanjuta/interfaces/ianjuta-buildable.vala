/**
 * SECTION:ianjuta-buildable
 * @title: IAnjutaBuildable
 * @short_description: Implemented by plugins that can build. This interface
 * will be replaced by #IAnjutaBuilder (for build functions) and
 * #IAnjutaEnvironment for ianjuta_buildable_set_command,
 * ianjuta_buildable_reset_command and ianjuta_buildable_get_command.
 * @see_also:
 * @stability: Obsolete
 * @include: libanjuta/interfaces/libanjuta-interfaces.h
 *
 */

/**
 * IAnjutaBuildableCommand:
 * @IANJUTA_BUILDABLE_COMMAND_COMPILE: Compile source
 * @IANJUTA_BUILDABLE_COMMAND_BUILD: Build file (normally using make)
 * @IANJUTA_BUILDABLE_COMMAND_BUILD_TARBALL: make dist
 * @IANJUTA_BUILDABLE_COMMAND_INSTALL: make install
 * @IANJUTA_BUILDABLE_COMMAND_CONFIGURE: ./configure
 * @IANJUTA_BUILDABLE_COMMAND_GENERATE: ./autogen.sh
 * @IANJUTA_BUILDABLE_COMMAND_CLEAN: make clean
 * @IANJUTA_BUILDABLE_COMMAND_EXECUTE: ./hello
 * @IANJUTA_BUILDABLE_COMMAND_IS_BUILT: check whether object files are up-to-date
 * @IANJUTA_BUILDABLE_COMMAND_DISTCLEAN: make distclean
 * @IANJUTA_BUILDABLE_N_COMMANDS: size of enum
 *
 * The enumeration is used to speficy the disered build operation
 */

public enum IAnjuta.BuildableCommand
{
	COMPILE,
	BUILD,
	BUILD_TARBALL,
	INSTALL,
	CONFIGURE,
	GENERATE,
	CLEAN,
	EXECUTE,
	IS_BUILT,
	AUTORECONF,
	DISTCLEAN,
	[CCode (cname="IANJUTA_BUILDABLE_N_COMMANDS")]
	N_COMMANDS
}

public interface IAnjuta.Buildable : Object
{
	/**
	 * ianjuta_buildable_set_command:
	 * @self: Self
	 * @command_id: Command to override.
	 * @command: Build command to override.
	 * @error: Error propagation and reporting.
	 *
	 * Overrides the default command for the given command.
	 */
	public abstract void set_command (BuildableCommand command_id, string command) throws Error;

	/**
	 * ianjuta_buildable_get_command:
	 * @self: Self
	 * @command_id: Command to get override.
	 * @error: Error propagation and reporting.
	 *
	 * Retrieves the currently set command override.
	 *
	 * Returns: The overridden command. NULL if no override set.
	 */
	public abstract unowned string? get_command (BuildableCommand command_id) throws Error;

	/**
	 * ianjuta_buildable_reset_commands:
	 * @self: Self
	 * @error: Error propagation and reporting.
	 *
	 * Resets the command overrides to defaults.
	 */
	public abstract void reset_commands () throws Error;

	/**
	 * ianjuta_buildable_build:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void build (string uri) throws Error;

	/**
	 * ianjuta_buildable_clean:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void clean (string uri) throws Error;

	/**
	 * ianjuta_buildable_install:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void install (string uri) throws Error;

	/**
	 * ianjuta_buildable_configure:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void configure (string uri) throws Error;

	/**
	 * ianjuta_buildable_generate:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void generate (string uri) throws Error;

	/**
	 * ianjuta_buildable_execute:
	 * @self: Self
	 * @uri: fixme
	 * @error: Error propagation and reporting.
	 *
	 * fixme
	 */
	public abstract void execute (string uri) throws Error;
}
