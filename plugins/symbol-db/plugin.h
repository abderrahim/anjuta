/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * plugin.h
 * Copyright (C) Massimo Cora' 2007-2008 <maxcvs@email.it>
 * 
 * plugin.h is free software.
 * 
 * You may redistribute it and/or modify it under the terms of the
 * GNU General Public License, as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option)
 * any later version.
 * 
 * plugin.h is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with plugin.h.  If not, write to:
 * 	The Free Software Foundation, Inc.,
 * 	51 Franklin Street, Fifth Floor
 * 	Boston, MA  02110-1301, USA.
 */

#ifndef _SYMBOL_DB_H_
#define _SYMBOL_DB_H_

#include <libanjuta/anjuta-plugin.h>
#include <libanjuta/anjuta-launcher.h>
#include "symbol-db-engine.h"


G_BEGIN_DECLS

extern GType symbol_db_get_type (GTypeModule *module);
#define ANJUTA_TYPE_PLUGIN_SYMBOL_DB         (symbol_db_get_type (NULL))
#define ANJUTA_PLUGIN_SYMBOL_DB(o)           (G_TYPE_CHECK_INSTANCE_CAST ((o), ANJUTA_TYPE_PLUGIN_SYMBOL_DB, SymbolDBPlugin))
#define ANJUTA_PLUGIN_SYMBOL_DB_CLASS(k)     (G_TYPE_CHECK_CLASS_CAST ((k), ANJUTA_TYPE_PLUGIN_SYMBOL_DB, SymbolDBPluginClass))
#define ANJUTA_IS_PLUGIN_SYMBOL_DB(o)        (G_TYPE_CHECK_INSTANCE_TYPE ((o), ANJUTA_TYPE_PLUGIN_SYMBOL_DB))
#define ANJUTA_IS_PLUGIN_SYMBOL_DB_CLASS(k)  (G_TYPE_CHECK_CLASS_TYPE ((k), ANJUTA_TYPE_PLUGIN_SYMBOL_DB))
#define ANJUTA_PLUGIN_SYMBOL_DB_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), ANJUTA_TYPE_PLUGIN_SYMBOL_DB, SymbolDBPluginClass))


typedef struct _SymbolDBPlugin SymbolDBPlugin;
typedef struct _SymbolDBPluginClass SymbolDBPluginClass;


#include "symbol-db-system.h"
#include "symbol-db-prefs.h"

/* default value for ctags executable. User must have it installed. This is a 
 * personalized version of ctags for Anjuta.
 */
#define CTAGS_PATH	PACKAGE_BIN_DIR"/anjuta-tags"

struct _SymbolDBPlugin {
	AnjutaPlugin parent;
	AnjutaUI *ui;
	AnjutaPreferences *prefs;
	
	/* project monitor */
	guint root_watch_id;
	
	/* ui merge */
	GtkActionGroup *popup_action_group;
	GtkActionGroup *menu_action_group;	
	gint merge_id;
	
	/* editor monitor */
	guint buf_update_timeout_id;
	gboolean need_symbols_update;
	GTimer *update_timer;
	GPtrArray *buffer_update_files;
	GPtrArray *buffer_update_ids;
	gboolean buffer_update_semaphore;		/* it monitors the update status of the
	 										 * buffer _and_ the editor switching.
	 										 * A new page cannot be updated with the
	 										 * new view-locals symbols if a scanning
	 										 * is in progress 
	 										 */
	guint editor_watch_id;
	gchar *project_root_uri;
	gchar *project_root_dir;
	gchar *project_opened;
	
	/* Symbol's engine connection to database. Instance for local project */
	SymbolDBEngine *sdbe_project;
	
	/* global's one */
	SymbolDBEngine *sdbe_globals;
	
	/* system's population object */
	SymbolDBSystem *sdbs;
	
	/* preferences object */
	SymbolDBPrefs *sdbp;
	
	GtkWidget *dbv_main;					/* symbol main window [gtk_box] */
	GtkWidget *dbv_notebook;          		/* main notebook */
	GtkWidget *dbv_hbox;					/* hbox for notebook buttons */
	GtkWidget *scrolled_global; 			/* symbol view scrolledwindow for global
										   	symbols */

	GtkWidget *local_button;
	GtkWidget *global_button;
	GtkWidget *search_button;
	
	GtkWidget *scrolled_locals;
	GtkWidget *scrolled_search;
	GtkWidget *progress_bar_project;		/* symbol db progress bar - project */
	GtkWidget *progress_bar_system;			/* symbol db progress bar - system (globals) */
	
	GtkWidget *dbv_view_tree;        		/* symbol_db_view globals */
	GtkWidget *dbv_view_tab_label;
	
	GtkWidget *dbv_view_tree_locals;		/* local symbols */
	GtkWidget *dbv_view_locals_tab_label;
	
	GtkWidget *dbv_view_tree_search;		/* search symbols */
	GtkWidget *dbv_view_search_tab_label;	
	
	GtkWidget *pref_tree_view; 				/* Preferences treeview */
	
	/* current editor */
	GObject *current_editor;
	GHashTable *editor_connected;	
	
	/* In session loading? */
	gboolean session_loading;
	
	gint files_count_project;
	gint files_count_project_done;
	
	gint files_count_system;
	gint files_count_system_done;
	gchar *current_scanned_package;
	GList *session_packages;
	
	GTree *proc_id_tree;				/* the scan processes'll receive an id from 
	 									 * the symbol engine when scan-end happens. 
	 									 * Track them here */
	
	gboolean is_project_importing;		/* refreshes or resumes after abort */
	gboolean is_project_updating;		/* makes up to date symbols of the project's files */
	gboolean is_offline_scanning;		/* detects offline changes to makefile.am */
	gboolean is_adding_element;			/* we're adding an element */
};

struct _SymbolDBPluginClass {
	AnjutaPluginClass parent_class;
	
	/* signals */
	void (* project_import_end) 	();
	void (* globals_import_end) 	();
	
};



G_END_DECLS

#endif
