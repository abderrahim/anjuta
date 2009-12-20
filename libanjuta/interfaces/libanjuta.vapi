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

[CCode (cheader_filename = "libanjuta/gbf-project.h")]
public class Gbf.Project : GLib.Object {}

