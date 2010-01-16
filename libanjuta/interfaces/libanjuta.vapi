/* This file contains only declarations interfaces */

[CCode (cheader_filename = "libanjuta/anjuta-plugin.h")]
public class Anjuta.Plugin : GLib.Object {}

[CCode (cheader_filename = "libanjuta/anjuta-plugin-handle.h")]
public class Anjuta.PluginHandle : GLib.Object {}

[CCode (cheader_filename = "libanjuta/anjuta-shell.h")]
public interface Anjuta.Shell : GLib.Object {}

[CCode (cheader_filename = "libanjuta/anjuta-preferences.h")]
public class Anjuta.Preferences : GLib.Object {}

[CCode (cheader_filename = "libanjuta/anjuta-async-notify.h")]
public class Anjuta.AsyncNotify : GLib.Object {}

[CCode (cheader_filename = "libanjuta/anjuta-vcs-status.h")]
public enum Anjuta.VcsStatus {
	MODIFIED,
	ADDED,
	DELETED,
	CONFLICTED,
	UPTODATE,
	LOCKED,
	MISSING,
	UNVERSIONED,
	IGNORED
}

[CCode (cprefix="ANJUTA_PROJECT_", cheader_filename = "libanjuta/anjuta-project.h")]
public enum Anjuta.ProjectNodeType
{
	UNKNOWN,
	GROUP,
	TARGET,
	SOURCE,
	VARIABLE
}

[CCode (cprefix="ANJUTA_TARGET_", cheader_filename = "libanjuta/anjuta-project.h")]
public enum Anjuta.ProjectTargetClass
{
	UNKNOWN,
	SHAREDLIB,
	STATICLIB,
	EXECUTABLE,
	PYTHON,
	JAVA,
	LISP,
	HEADER,
	MAN,
	INFO,
	GENERIC,
	DATA,
	EXTRA,
	INTLTOOL,
	CONFIGURE,
	IDL,
	MKENUMS,
	GENMARSHAL
}

[CCode (cheader_filename = "libanjuta/anjuta-project.h")]
public class Anjuta.ProjectNode : GLib.Node <void*> {}

[CCode (cheader_filename = "libanjuta/anjuta-project.h")]
public class Anjuta.ProjectGroup : Anjuta.ProjectNode {}

[CCode (cheader_filename = "libanjuta/anjuta-project.h")]
public class Anjuta.ProjectTarget : Anjuta.ProjectNode {}

[CCode (cheader_filename = "libanjuta/anjuta-project.h")]
public class Anjuta.ProjectSource : Anjuta.ProjectNode {}

[CCode (cheader_filename = "libanjuta/anjuta-project.h")]
public struct Anjuta.ProjectTargetInformation
{
	string name;
	ProjectTargetClass base;
	string mime_type;
}

