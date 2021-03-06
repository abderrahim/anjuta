/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * anjuta
 * Copyright (C) James Liggett 2008 <jrliggett@cox.net>
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

#include "git-switch-dialog.h"

static void
on_checkout_command_finished (AnjutaCommand *command, guint return_code,
						   Git *plugin)
{
	AnjutaStatus *status;
	
	status = anjuta_shell_get_status (ANJUTA_PLUGIN (plugin)->shell,
									  NULL);
	
	anjuta_status (status, _("Git: Branch checkout complete."), 5);
	
	git_report_errors (command, return_code);
	
	g_object_unref (command);
}


static void
on_switch_dialog_response (GtkDialog *dialog, gint response_id, 
						   GitUIData *data)
{
	GtkWidget *switch_branch_combo;
	GtkTreeModel *branch_combo_model;
	gchar *branch;
	GtkTreeIter iter;
	GitBranchCheckoutCommand *checkout_command;
	
	if (response_id == GTK_RESPONSE_OK)
	{	
		switch_branch_combo = GTK_WIDGET (gtk_builder_get_object (data->bxml, 
		                                                          "switch_branch_combo"));
		branch_combo_model = GTK_TREE_MODEL (gtk_builder_get_object (data->bxml,
	                                                         		 "branch_combo_model"));

		if (!git_check_branches (GTK_COMBO_BOX (switch_branch_combo)))
			return;

		gtk_combo_box_get_active_iter (GTK_COMBO_BOX (switch_branch_combo), &iter);
		gtk_tree_model_get (branch_combo_model, &iter, 0, &branch, -1);
		

		checkout_command = git_branch_checkout_command_new (data->plugin->project_root_directory,
															branch);
		
		g_free (branch);
		
		git_create_message_view (data->plugin);
		
		g_signal_connect (G_OBJECT (checkout_command), "command-finished",
						  G_CALLBACK (on_checkout_command_finished),
						  data->plugin);
		
		g_signal_connect (G_OBJECT (checkout_command), "data-arrived",
						  G_CALLBACK (on_git_command_info_arrived),
						  data->plugin);
		
		anjuta_command_start (ANJUTA_COMMAND (checkout_command));
	}
	
	gtk_widget_destroy (GTK_WIDGET (dialog));
	git_ui_data_free (data);
}

static void
switch_dialog (Git *plugin)
{
	GtkBuilder *bxml;
	gchar *objects[] = {"switch_dialog", "branch_combo_model", NULL};
	GError *error;
	GtkWidget *dialog;
	GtkWidget *switch_branch_combo;
	GtkListStore *branch_combo_model;
	GitUIData *data;
	GitBranchListCommand *list_command;
	
	bxml = gtk_builder_new ();
	error = NULL;

	if (!gtk_builder_add_objects_from_file (bxml, BUILDER_FILE, objects, 
	                                        &error))
	{
		g_warning ("Couldn't load builder file: %s", error->message);
		g_error_free (error);
	}
	
	dialog = GTK_WIDGET (gtk_builder_get_object (bxml, "switch_dialog"));
	switch_branch_combo = GTK_WIDGET (gtk_builder_get_object (bxml, 
	                                                          "switch_branch_combo"));
	branch_combo_model = GTK_LIST_STORE (gtk_builder_get_object (bxml,
	                                                             "branch_combo_model"));
	
	data = git_ui_data_new (plugin, bxml);
	
	list_command = git_branch_list_command_new (plugin->project_root_directory,
												GIT_BRANCH_TYPE_LOCAL);
	
	g_signal_connect (G_OBJECT (list_command), "data-arrived", 
					  G_CALLBACK (on_git_list_branch_combo_command_data_arrived), 
					  branch_combo_model);
	
	g_signal_connect (G_OBJECT (list_command), "command-finished", 
					  G_CALLBACK (on_git_list_branch_combo_command_finished), 
					  switch_branch_combo);
	
	anjuta_command_start (ANJUTA_COMMAND (list_command));
	
	g_signal_connect (G_OBJECT (dialog), "response", 
					  G_CALLBACK (on_switch_dialog_response), 
					  data);
	
	gtk_widget_show_all (dialog);
}

void
on_menu_git_switch (GtkAction *action, Git *plugin)
{
	switch_dialog (plugin);
}
