/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * anjuta
 * Copyright (C) James Liggett 2007 <jrliggett@cox.net>
 * 
 * anjuta is free software.
 * 
 * You may redistribute it and/or modify it under the terms of the
 * GNU General Public License, as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option)
 * any later version.
 * 
 * anjuta is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with anjuta.  If not, write to:
 * 	The Free Software Foundation, Inc.,
 * 	51 Franklin Street, Fifth Floor
 * 	Boston, MA  02110-1301, USA.
 */

#include "git-ui-utils.h"

/* Private structure for pulse progress */
typedef struct
{
	AnjutaStatus *status;
	gchar *text;
} PulseProgressData;

GitUIData* 
git_ui_data_new (Git* plugin, GtkBuilder *bxml)
{
	GitUIData* data = g_new0 (GitUIData, 1);
	data->plugin = plugin;
	data->bxml = bxml;
	
	return data;
}

void 
git_ui_data_free (GitUIData* data)
{
	g_object_unref (data->bxml);
	g_free (data);
}

GitProgressData *
git_progress_data_new (Git *plugin, const gchar *text)
{
	GitProgressData *data;
	AnjutaStatus *status;
	
	data = g_new0 (GitProgressData, 1);
	data->plugin = plugin;
	data->text = g_strdup (text);
	data->last_progress = 100; /* Add the ticks when we get a progress signal */
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell, NULL);
	
	return data;
}

void
git_progress_data_free (GitProgressData *data)
{	
	g_free (data->text);
	g_free (data);
}

static void
on_message_view_destroy (Git* plugin, gpointer destroyed_view)
{
	plugin->message_view = NULL;
}

void
git_create_message_view (Git *plugin)
{
	IAnjutaMessageManager* message_manager; 
		
		
	message_manager = anjuta_shell_get_interface  (ANJUTA_PLUGIN (plugin)->shell,	
												   IAnjutaMessageManager, NULL);
	plugin->message_view =  ianjuta_message_manager_get_view_by_name (message_manager, 
																	  _("Git"), 
																	  NULL);
	if (!plugin->message_view)
	{
		plugin->message_view = ianjuta_message_manager_add_view (message_manager, 
																 _("Git"), 
																 ICON_FILE, 
																 NULL);
		g_object_weak_ref (G_OBJECT (plugin->message_view), 
						   (GWeakNotify) on_message_view_destroy, plugin);
	}
	
	ianjuta_message_view_clear(plugin->message_view, NULL);
	ianjuta_message_manager_set_current_view (message_manager, 
											  plugin->message_view, 
											  NULL);
}

gboolean 
git_check_input (GtkWidget *parent, GtkWidget *widget, const gchar *input, 
				 const gchar *error_message)
{
	gboolean ret;
	GtkWidget *dialog;
	
	ret = FALSE;
	
	if (input)
	{
		if (strlen (input) > 0)
			ret = TRUE;
	}
	
	if (!ret)
	{
		dialog = gtk_message_dialog_new (GTK_WINDOW (parent),
										 GTK_DIALOG_DESTROY_WITH_PARENT,
										 GTK_MESSAGE_WARNING,
										 GTK_BUTTONS_OK,
		                                 "%s",
										 error_message);
		
		gtk_dialog_run (GTK_DIALOG (dialog));
		gtk_widget_destroy (dialog);
		
		gtk_window_set_focus (GTK_WINDOW (parent), widget);
	}

	
	return ret;
}

gboolean
git_check_branches (GtkComboBox *combo_box)
{
	gint ret;
	GtkWidget *parent;
	GtkWidget *dialog;
	
	ret = (gtk_combo_box_get_active (combo_box) > -1);

	if (!ret)
	{
		parent = gtk_widget_get_toplevel (GTK_WIDGET (combo_box));
		dialog = gtk_message_dialog_new (GTK_WINDOW (parent),
										 GTK_DIALOG_DESTROY_WITH_PARENT,
										 GTK_MESSAGE_WARNING,
										 GTK_BUTTONS_OK,
		                                 "%s",
										 _("There are no branches available."));
		
		gtk_dialog_run (GTK_DIALOG (dialog));
		gtk_widget_destroy (dialog);
		
	}

	return ret;
}

gboolean
git_get_selected_stash (GtkTreeSelection *selection, gchar **stash)
{
	gboolean ret;
	GtkTreeModel *model;
	GtkTreeIter iter;
	GtkWidget *stash_view;
	GtkWidget *parent;
	GtkWidget *dialog;

	ret = FALSE;
	*stash = NULL;

	if (gtk_tree_selection_get_selected (selection, &model, &iter))
	{
		gtk_tree_model_get (model, &iter, 0, stash, -1);
		ret = TRUE;
	}
	else
	{
		stash_view = GTK_WIDGET (gtk_tree_selection_get_tree_view (selection));
		parent = gtk_widget_get_toplevel (stash_view);
		dialog = gtk_message_dialog_new (GTK_WINDOW (parent),
										 GTK_DIALOG_DESTROY_WITH_PARENT,
										 GTK_MESSAGE_WARNING,
										 GTK_BUTTONS_OK,
										 "%s", _("Please select a stash"));

		gtk_dialog_run (GTK_DIALOG (dialog));
		gtk_widget_destroy (dialog);
	}
	

	return ret;
}

gchar * 
git_get_log_from_textview (GtkWidget* textview)
{
	gchar* log;
	GtkTextBuffer* textbuf;
	GtkTextIter iterbegin, iterend;
	
	textbuf = gtk_text_view_get_buffer(GTK_TEXT_VIEW(textview));
	gtk_text_buffer_get_start_iter(textbuf, &iterbegin);
	gtk_text_buffer_get_end_iter(textbuf, &iterend) ;
	log = gtk_text_buffer_get_text(textbuf, &iterbegin, &iterend, FALSE);
	return log;
}

static gboolean
status_pulse_timer (PulseProgressData *data)
{
	anjuta_status_progress_pulse (data->status, data->text);
	return TRUE;
}

static gboolean
pulse_timer (GtkProgressBar *progress_bar)
{
	gtk_progress_bar_pulse (progress_bar);
	return TRUE;
}

static void
on_pulse_timer_destroyed (PulseProgressData *data)
{
	anjuta_status_progress_reset (data->status);
	
	g_free (data->text);
	g_free (data);
}

guint
git_status_bar_progress_pulse (Git *plugin, gchar *text)
{
	PulseProgressData *data;
	
	data = g_new0 (PulseProgressData, 1);
	data->status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell, 
											NULL);
	data->text = g_strdup (text);
	
	return g_timeout_add_full (G_PRIORITY_DEFAULT, 100,  
							   (GSourceFunc) status_pulse_timer, data,
							   (GDestroyNotify) on_pulse_timer_destroyed);
}

void
git_clear_status_bar_progress_pulse (guint timer_id)
{
	g_source_remove (timer_id);
}

static void
message_dialog (GtkMessageType message_type, const gchar *message)
{
	GtkWidget *dialog;
	GtkWidget *close_button;
	GtkWidget *content_area;
	GtkWidget *hbox;
	GtkWidget *image;
	GtkWidget *scrolled_window;
	GtkWidget *text_view;
	GtkTextBuffer *text_buffer;

	dialog = gtk_dialog_new_with_buttons (NULL,
	                                      NULL,
	                                      GTK_DIALOG_DESTROY_WITH_PARENT,
	                                      NULL);

	close_button = gtk_dialog_add_button (GTK_DIALOG (dialog), GTK_STOCK_CLOSE,
	                                      GTK_RESPONSE_CLOSE);
	content_area = gtk_dialog_get_content_area (GTK_DIALOG (dialog));
	hbox = gtk_hbox_new (FALSE, 2);
	image = gtk_image_new ();
	scrolled_window = gtk_scrolled_window_new (NULL, NULL);
	text_view = gtk_text_view_new ();
	text_buffer = gtk_text_view_get_buffer (GTK_TEXT_VIEW (text_view));

	switch (message_type)
	{
		case GTK_MESSAGE_ERROR:
			gtk_image_set_from_icon_name (GTK_IMAGE (image), 
			                              GTK_STOCK_DIALOG_ERROR, 
			                              GTK_ICON_SIZE_DIALOG);
			break;
		case GTK_MESSAGE_WARNING:
			gtk_image_set_from_icon_name (GTK_IMAGE (image), 
			                              GTK_STOCK_DIALOG_WARNING,
			                              GTK_ICON_SIZE_DIALOG);
			break;
		default:
			break;
	}

	gtk_dialog_set_has_separator (GTK_DIALOG (dialog), FALSE);
	gtk_widget_set_size_request (text_view, 500, 150);
	
	gtk_container_add (GTK_CONTAINER (scrolled_window), text_view);
	gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_window),
	                                     GTK_SHADOW_IN);

	gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window),
	                                GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);

	gtk_text_view_set_editable (GTK_TEXT_VIEW (text_view), FALSE);
	gtk_text_buffer_set_text (text_buffer, message, strlen (message));

	gtk_box_pack_start (GTK_BOX (hbox), image, FALSE, FALSE, 0);
	gtk_box_pack_start (GTK_BOX (hbox), scrolled_window, TRUE, TRUE, 0);

	gtk_box_pack_start (GTK_BOX (content_area), hbox, TRUE, TRUE, 0);

	gtk_widget_grab_default (close_button);
	gtk_widget_grab_focus (close_button);

	g_signal_connect (G_OBJECT (dialog), "response",
	                  G_CALLBACK (gtk_widget_destroy),
	                  NULL);

	gtk_widget_show_all (dialog);
	
}

void
git_report_errors (AnjutaCommand *command, guint return_code)
{
	gchar *message;
	
	/* In some cases, git might report errors yet still indicate success.
	 * When this happens, use a warning dialog instead of an error, so the user
	 * knows that something actually happened. */
	message = anjuta_command_get_error_message (command);
	
	if (message)
	{
		if (return_code != 0)
			message_dialog (GTK_MESSAGE_ERROR, message);
		else
			message_dialog (GTK_MESSAGE_WARNING, message);
		
		g_free (message);
	}
}

static void
stop_pulse_timer (gpointer timer_id, GtkProgressBar *progress_bar)
{
	g_source_remove (GPOINTER_TO_UINT (timer_id));
}

void
git_pulse_progress_bar (GtkProgressBar *progress_bar)
{
	guint timer_id;
	
	timer_id = g_timeout_add (100, (GSourceFunc) pulse_timer, 
							  progress_bar);
	g_object_set_data (G_OBJECT (progress_bar), "pulse-timer-id",
					   GUINT_TO_POINTER (timer_id));
	
	g_object_weak_ref (G_OBJECT (progress_bar),
					   (GWeakNotify) stop_pulse_timer,
					   GUINT_TO_POINTER (timer_id));
}

gchar *
git_get_filename_from_full_path (gchar *path)
{
	gchar *last_slash;
	
	last_slash = strrchr (path, '/');
	
	/* There might be a trailing slash in the string */
	if ((last_slash - path) < strlen (path))
		return g_strdup (last_slash + 1);
	else
		return g_strdup ("");
}

const gchar *
git_get_relative_path (const gchar *path, const gchar *working_directory)
{
	/* Path could already be a relative path */
	if (strstr (path, working_directory))
		return path + strlen (working_directory) + 1;
	else 
		return path;
}

void
on_git_command_finished (AnjutaCommand *command, guint return_code, 
						 gpointer user_data)
{
	git_report_errors (command, return_code);
	
	g_object_unref (command);
}

void
on_git_status_command_data_arrived (AnjutaCommand *command, 
									AnjutaVcsStatusTreeView *tree_view)
{
	GQueue *status_queue;
	GitStatus *status;
	gchar *path;
	
	status_queue = git_status_command_get_status_queue (GIT_STATUS_COMMAND (command));
	
	while (g_queue_peek_head (status_queue))
	{
		status = g_queue_pop_head (status_queue);
		path = git_status_get_path (status);
		
		anjuta_vcs_status_tree_view_add (tree_view, path, 
								  git_status_get_vcs_status (status),
								  FALSE);
		
		g_object_unref (status);
		g_free (path);
	}
}

void
on_git_command_info_arrived (AnjutaCommand *command, Git *plugin)
{
	GQueue *info;
	gchar *message;
	
	info = git_command_get_info_queue (GIT_COMMAND (command));
	
	while (g_queue_peek_head (info))
	{
		message = g_queue_pop_head (info);
		ianjuta_message_view_append (plugin->message_view, 
								     IANJUTA_MESSAGE_VIEW_TYPE_NORMAL,
									 message, "", NULL);
		g_free (message);
	}
}

void
on_git_command_progress (AnjutaCommand *command, gfloat progress, 
						 GitProgressData *data)
{
	AnjutaStatus *status;
	gint ticks;
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (data->plugin)->shell, 
									  NULL);
	
	/* There are cases where there are multiple stages to a task, and each 
	 * has their own progress indicator. If one stage has completed and another
	 * is beginning, add another 100 ticks to reflect the progress of this new
	 * stage. */
	if (data->last_progress == 100)
	{
		anjuta_status_progress_add_ticks (status, 100);
		data->last_progress = 0;
	}

	ticks = progress * 100;
	anjuta_status_progress_increment_ticks (status, 
											(ticks - data->last_progress),
											data->text);
	data->last_progress = ticks;
}

void
on_git_list_branch_combo_command_data_arrived (AnjutaCommand *command,
                                               GtkListStore *branch_combo_model)
{
	GQueue *output_queue;
	GitBranch *branch;
	GtkTreeIter iter;
	gchar *name;
	
	output_queue = git_branch_list_command_get_output (GIT_BRANCH_LIST_COMMAND (command));

	while (g_queue_peek_head (output_queue))
	{
		branch = g_queue_pop_head (output_queue);
		name = git_branch_get_name (branch);

		if (!git_branch_is_active (branch))
		{
			gtk_list_store_append (branch_combo_model, &iter);
			gtk_list_store_set (branch_combo_model, &iter, 0, name, -1);
		}

		g_object_unref (branch);
		g_free (name);
	}
}

/* This function is used for selection lists. */
void
on_git_list_branch_command_data_arrived (AnjutaCommand *command,
										 GtkListStore *branch_list_model)
{
	GQueue *output_queue;
	GitBranch *branch;
	GtkTreeIter iter;
	gchar *name;
	
	output_queue = git_branch_list_command_get_output (GIT_BRANCH_LIST_COMMAND (command));

	while (g_queue_peek_head (output_queue))
	{
		branch = g_queue_pop_head (output_queue);
		name = git_branch_get_name (branch);

		gtk_list_store_append (branch_list_model, &iter);
		gtk_list_store_set (branch_list_model, &iter, 1, name, -1);
		
		g_object_unref (branch);
		g_free (name);
	}
}

void
on_git_list_branch_combo_command_finished (AnjutaCommand *command, 
                                           guint return_code,
                                           GtkComboBox *combo_box)
{
	gtk_combo_box_set_active (combo_box, 0);
	
	git_report_errors (command, return_code);
	g_object_unref (command);
}


void
on_git_list_tag_command_data_arrived (AnjutaCommand *command,
                              		  GtkListStore *tag_list_model)
{
	GQueue *output_queue;
	gchar *tag_name;
	GtkTreeIter iter;
	
	output_queue = git_raw_output_command_get_output (GIT_RAW_OUTPUT_COMMAND (command));
	
	while (g_queue_peek_head (output_queue))
	{
		tag_name = g_queue_pop_head (output_queue);

		gtk_list_store_append (tag_list_model, &iter);
		gtk_list_store_set (tag_list_model, &iter, 1, tag_name, -1);
		
		g_free (tag_name);
	}
}

void
on_git_list_stash_command_data_arrived (AnjutaCommand *command,
										GtkListStore *stash_list_model)
{
	GQueue *output_queue;
	GitStash *stash;
	GtkTreeIter iter;
	gchar *id;
	gchar *message;
	guint number;
	
	output_queue = git_stash_list_command_get_output (GIT_STASH_LIST_COMMAND (command));

	while (g_queue_peek_head (output_queue))
	{
		stash = g_queue_pop_head (output_queue);
		id = git_stash_get_id (stash);
		message = git_stash_get_message (stash);
		number = git_stash_get_number (stash);

		gtk_list_store_append (stash_list_model, &iter);
		gtk_list_store_set (stash_list_model, &iter, 
							0, id,
							1, message,
		                    2, number,
							-1);
		
		g_object_unref (stash);
		g_free (id);
		g_free (message);
	}
}

void
on_git_stash_save_command_finished (AnjutaCommand *command, guint return_code,
									Git *plugin)
{
	AnjutaStatus *status;
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell,
									  NULL);
	
	anjuta_status (status, _("Git: Changes stored in a stash."), 5);
	
	git_report_errors (command, return_code);
	
	g_object_unref (command);
}

void
on_git_stash_apply_command_finished (AnjutaCommand *command, guint return_code,
									 Git *plugin)
{
	AnjutaStatus *status;
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell,
									  NULL);
	
	anjuta_status (status, _("Git: Stashed changes applied."), 5);
	
	git_report_errors (command, return_code);
	
	g_object_unref (command);
}

void
on_git_remote_list_command_data_arrived (AnjutaCommand *command,
                                         GtkListStore *remote_list_model)
{
	GtkWidget *origin_check;
	GQueue *output_queue;
	gchar *remote_name;
	GtkTreeIter iter;
	
	origin_check = g_object_get_data (G_OBJECT (command), "origin-check");
	output_queue = git_raw_output_command_get_output (GIT_RAW_OUTPUT_COMMAND (command));
	
	while (g_queue_peek_head (output_queue))
	{
		remote_name = g_queue_pop_head (output_queue);

		/* Don't show the origin branch in the list. Origin is specified by 
		 * enabling the origin checkbox. As use of origin is such a common 
		 * operation, give access to it in one click. Keep the checkbox disabled
		 * if no origin branch exists. */
		if (strcmp (remote_name, "origin") != 0)
		{
			gtk_list_store_append (remote_list_model, &iter);
			gtk_list_store_set (remote_list_model, &iter, 0, remote_name, -1);
		}
		else
			gtk_widget_set_sensitive (origin_check, TRUE);
		
		g_free (remote_name);
	}
}

void
on_git_notebook_button_toggled (GtkToggleButton *toggle_button,
                                GtkNotebook *notebook)
{
	gint tab_index;

	if (gtk_toggle_button_get_active (toggle_button))
	{
		tab_index = GPOINTER_TO_INT (g_object_get_data (G_OBJECT (toggle_button),
		                                                "tab-index"));

		gtk_notebook_set_current_page (notebook, tab_index);
	}
}

void
git_select_all_status_items (GtkButton *select_all_button,
							 AnjutaVcsStatusTreeView *tree_view)
{
	anjuta_vcs_status_tree_view_select_all (tree_view);
}

void
git_clear_all_status_selections (GtkButton *clear_button,
								 AnjutaVcsStatusTreeView *tree_view)
{
	anjuta_vcs_status_tree_view_unselect_all (tree_view);
}

void
on_git_origin_check_toggled (GtkToggleButton *button, GtkWidget *widget)
{
	gtk_widget_set_sensitive (widget, !gtk_toggle_button_get_active (button));
}

void 
git_init_whole_project (Git *plugin, GtkWidget* project, gboolean active)
{
	gboolean project_loaded;
	
	project_loaded = (plugin->project_root_directory != NULL);
	
	gtk_widget_set_sensitive(project, project_loaded);
	
	if (project_loaded)
		gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (project), active);
}	

void 
on_git_whole_project_toggled (GtkToggleButton* project, Git *plugin)
{
	GtkWidget *path_entry;
	
	path_entry = g_object_get_data (G_OBJECT (project), "file-entry");
	
	gtk_widget_set_sensitive (path_entry, 
							  !gtk_toggle_button_get_active (project));
}

void
git_send_raw_command_output_to_editor (AnjutaCommand *command, 
									   IAnjutaEditor *editor)
{
	GQueue *output;
	gchar *line;
	
	output = git_raw_output_command_get_output (GIT_RAW_OUTPUT_COMMAND (command));
	
	while (g_queue_peek_head (output))
	{
		line = g_queue_pop_head (output);
		ianjuta_editor_append (editor, line, strlen (line), NULL);
		g_free (line);
	}
}

void
on_git_diff_command_finished (AnjutaCommand *command, guint return_code, 
							  Git *plugin)
{
	AnjutaStatus *status;
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell,
									  NULL);
	
	anjuta_status (status, _("Git: Diff complete."), 5);
	
	git_report_errors (command, return_code);
	
	g_object_unref (command);	
}

void
git_set_log_view_column_label (GtkTextBuffer *text_buffer,
                               GtkTextIter *location, GtkTextMark *mark,
                               GtkLabel *column_label)
{
	gint column;
	gchar *text;

	column = gtk_text_iter_get_line_offset (location) + 1;
	text = g_strdup_printf (_("Column %i"), column);

	gtk_label_set_text (column_label, text);

	g_free (text);
}

void
git_stop_status_bar_progress_pulse (AnjutaCommand *command, guint return_code,
									gpointer timer_id)
{
	git_clear_status_bar_progress_pulse (GPOINTER_TO_UINT (timer_id));
}

void
git_hide_pulse_progress_bar (AnjutaCommand *command, guint return_code,
							 GtkProgressBar *progress_bar)
{
	guint timer_id;
	
	/* If the progress bar has already been destroyed, the timer should be 
	 * stopped by stop_pulse_timer */
	if (GTK_IS_PROGRESS_BAR (progress_bar))
	{
		timer_id = GPOINTER_TO_UINT (g_object_get_data (G_OBJECT (progress_bar),
														"pulse-timer-id")); 
		
		g_source_remove (GPOINTER_TO_UINT (timer_id));
		gtk_widget_hide (GTK_WIDGET (progress_bar));
	}
}

/* This function is normally intended to disconnect stock data-arrived signal
 * handlers in this file. It is assumed that object is the user data for the 
 * callback. If you use any of the stock callbacks defined here, make sure 
 * to weak ref its target with this callback. Make sure to cancel this ref
 * by connecting git_cancel_data_arrived_signal_disconnect to the  
 * command-finished signal so we don't try to disconnect signals on a destroyed 
 * command. */
void
git_disconnect_data_arrived_signals (AnjutaCommand *command, GObject *object)
{
	guint data_arrived_signal;
	
	if (ANJUTA_IS_COMMAND (command))
	{
		data_arrived_signal = g_signal_lookup ("data-arrived",
											   ANJUTA_TYPE_COMMAND);
		
		g_signal_handlers_disconnect_matched (command,
											  G_SIGNAL_MATCH_DATA,
											  data_arrived_signal,
											  0,
											  NULL,
											  NULL,
											  object);
	}
										  
}

void 
git_cancel_data_arrived_signal_disconnect (AnjutaCommand *command, 
										   guint return_code,
										   GObject *signal_target)
{
	g_object_weak_unref (signal_target, 
						 (GWeakNotify) git_disconnect_data_arrived_signals,
						 command);
}


gboolean
git_get_selected_refs (GtkTreeModel *model, GtkTreePath *path, 
					   GtkTreeIter *iter, GList **selected_list)
{
	gboolean selected;
	gchar *name;

	gtk_tree_model_get (model, iter, 
						0, &selected,
						1, &name,
						-1);

	if (selected)
		*selected_list = g_list_append (*selected_list, name);

	return FALSE;
}

void
on_git_selected_column_toggled (GtkCellRendererToggle *renderer, gchar *path,
								GtkListStore *list_store)
{
	GtkTreeIter iter;
	gboolean selected;

	gtk_tree_model_get_iter_from_string (GTK_TREE_MODEL (list_store), &iter, 
										 path);

	gtk_tree_model_get (GTK_TREE_MODEL (list_store), &iter, 0, &selected, -1);
	
	gtk_list_store_set (list_store, &iter, 0, !selected, -1);
	
}
