INCLUDES = \
	$(WARN_CFLAGS) \
	$(GTK_CFLAGS) \
	$(DEPRECATED_FLAGS) \
	$(LIBANJUTA_CFLAGS) \
	-I$(top_srcdir) \
	-DG_LOG_DOMAIN=\"libanjuta-interfaces\" \
	"-DG_LOG_FATAL_MASK=\"(G_LOG_FLAG_RECURSION|G_LOG_LEVEL_ERROR|G_LOG_LEVEL_CRITICAL|G_LOG_LEVEL_WARNING)\""

AM_VALAFLAGS = -H libanjuta-interfaces.h --pkg posix --pkg gtk+-2.0 --library libanjuta-1.0 --gir IAnjuta-1.0.gir


BUILT_SOURCES = libanjuta-interfaces.h IAnjuta-1.0.gir
EXTRA_DIST = libanjuta-interfaces.h IAnjuta-1.0.gir


libanjuta-interfaces.h: libanjuta_interfaces_la_vala.stamp
	@true
libanjuta_interfaces_includedir = $(includedir)/libanjuta-1.0/libanjuta/interfaces
libanjuta_interfaces_include_HEADERS = libanjuta-interfaces.h


IAnjuta-1.0.gir: libanjuta_interfaces_la_vala.stamp
	@true

IAnjuta-1.0.typelib: IAnjuta-1.0.gir
	$(INTROSPECTION_COMPILER) $< -o $@

girdir = $(INTROSPECTION_GIRDIR)
gir_DATA = IAnjuta-1.0.gir

typelibdir = $(INTROSPECTION_TYPELIBDIR)
typelib_DATA = IAnjuta-1.0.typelib


noinst_LTLIBRARIES = libanjuta-interfaces.la
libanjuta_interfaces_la_LIBADD = $(GTK_LIBS)

libanjuta_interfaces_la_SOURCES = \
	libanjuta.vapi \
	ianjuta-buildable.vala \
	ianjuta-builder.vala \
	ianjuta-debugger-breakpoint.vala \
	ianjuta-debugger-instruction.vala \
	ianjuta-debugger-memory.vala \
	ianjuta-debugger-register.vala \
	ianjuta-debugger.vala \
	ianjuta-debugger-variable.vala \
	ianjuta-debug-manager.vala \
	ianjuta-document-manager.vala \
	ianjuta-document.vala \
	ianjuta-editor-assist.vala \
	ianjuta-editor-cell-style.vala \
	ianjuta-editor-cell.vala \
	ianjuta-editor-comment.vala \
	ianjuta-editor-convert.vala \
	ianjuta-editor-factory.vala \
	ianjuta-editor-folds.vala \
	ianjuta-editor-goto.vala \
	ianjuta-editor-hover.vala \
	ianjuta-editor-language.vala \
	ianjuta-editor-linemode.vala \
	ianjuta-editor-search.vala \
	ianjuta-editor-selection.vala \
	ianjuta-editor-tip.vala \
	ianjuta-editor.vala \
	ianjuta-editor-view.vala \
	ianjuta-editor-zoom.vala \
	ianjuta-environment.vala \
	ianjuta-file-loader.vala \
	ianjuta-file-manager.vala \
	ianjuta-file-savable.vala \
	ianjuta-file.vala \
	ianjuta-help.vala \
	ianjuta-indicable.vala \
	ianjuta-iterable-tree.vala \
	ianjuta-iterable.vala \
	ianjuta-language-support.vala \
	ianjuta-language.vala \
	ianjuta-loader.vala \
	ianjuta-macro.vala \
	ianjuta-markable.vala \
	ianjuta-message-manager.vala \
	ianjuta-message-view.vala \
	ianjuta-plugin-factory.vala \
	ianjuta-preferences.vala \
	ianjuta-print.vala \
	ianjuta-project.vala \
	ianjuta-project-backend.vala \
	ianjuta-project-manager.vala \
	ianjuta-provider.vala \
	ianjuta-stream-loader.vala \
	ianjuta-stream-savable.vala \
	ianjuta-stream.vala \
	ianjuta-symbol-manager.vala \
	ianjuta-symbol.vala \
	ianjuta-terminal.vala \
	ianjuta-todo.vala \
	ianjuta-vcs.vala \
	ianjuta-wizard.vala
