/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * anjuta
 * Copyright (C) James Liggett 2007 <jrliggett@cox.net>
 *
 * Portions based on the original Subversion plugin 
 * Copyright (C) Johannes Schmid 2005 
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

#include "svn-diff-command.h"

struct _SvnDiffCommandPriv
{
	GQueue *output;
	gchar *path;
	glong revision1;
	glong revision2;
	gboolean recursive;
};

G_DEFINE_TYPE (SvnDiffCommand, svn_diff_command, SVN_TYPE_COMMAND);

static void
svn_diff_command_init (SvnDiffCommand *self)
{
	self->priv = g_new0 (SvnDiffCommandPriv, 1);
	self->priv->output = g_queue_new ();
}

static void
svn_diff_command_finalize (GObject *object)
{
	SvnDiffCommand *self;
	GList *current_line;
	
	self = SVN_DIFF_COMMAND (object);
	
	current_line = self->priv->output->head;
	
	while (current_line)
	{
		g_free (current_line->data);
		current_line = g_list_next (current_line);
	}
	
	g_queue_free (self->priv->output);
	g_free (self->priv->path);
	g_free (self->priv);

	G_OBJECT_CLASS (svn_diff_command_parent_class)->finalize (object);
}

static guint 
svn_diff_command_run (AnjutaCommand *command)
{
	SvnDiffCommand *self;
	SvnCommand *svn_command;
	svn_opt_revision_t revision1;
	svn_opt_revision_t revision2;
	apr_array_header_t *options;
	apr_file_t *diff_file;
	gchar file_template[] = "anjuta-svn-diffXXXXXX";
	apr_size_t read_size;
	gchar *line;
	svn_error_t *error;
	apr_status_t apr_error;
	apr_off_t offset;
	
	self = SVN_DIFF_COMMAND (command);
	svn_command = SVN_COMMAND (self);
	
	switch (self->priv->revision1)
	{
		case SVN_DIFF_REVISION_NONE:
			/* Treat this as a diff between working copy and head */
			revision1.kind = svn_opt_revision_head;
			revision2.kind = svn_opt_revision_working;
			break;
		case SVN_DIFF_REVISION_PREVIOUS:
			/* Diff between selected revision and the one before it.
			 * This is relative to revision2. */
			revision1.kind = svn_opt_revision_number;
			revision1.value.number = self->priv->revision2 - 1;
			revision2.kind = svn_opt_revision_number;
			revision2.value.number = self->priv->revision2;
			break;
		default:
			/* Diff between two distinct revisions */
			revision1.kind = svn_opt_revision_number;
			revision1.value.number = self->priv->revision1;
			revision2.kind = svn_opt_revision_number;
			revision2.value.number = self->priv->revision2;
			break;
	}
	
	options = apr_array_make(svn_command_get_pool (SVN_COMMAND (command)), 
							 0, sizeof (char *));
	
	apr_file_mktemp (&diff_file, file_template, 0, 
					 svn_command_get_pool (SVN_COMMAND (command)));
	
	error = svn_client_diff3 (options,
							  self->priv->path,
							  &revision1,
							  self->priv->path,
							  &revision2,
							  self->priv->recursive,
							  FALSE,
							  FALSE,
							  FALSE,
							  SVN_APR_LOCALE_CHARSET,
							  diff_file,
							  NULL,
							  svn_command_get_client_context (svn_command),
							  svn_command_get_pool (svn_command));
	
	if (error)
	{
		svn_command_set_error (svn_command, error);
		return 1;
	}
	
	offset = 0;
	apr_file_seek (diff_file, APR_SET, &offset);
	
	while (apr_file_eof (diff_file) != APR_EOF)
	{
		read_size = 80;
		line = g_new0 (gchar, (read_size + 1));
		
		apr_error = apr_file_read (diff_file, line, &read_size);

		if (strlen (line))
		{
			anjuta_async_command_lock (ANJUTA_ASYNC_COMMAND (command));
			g_queue_push_tail (self->priv->output, g_strdup (line));
			anjuta_async_command_unlock (ANJUTA_ASYNC_COMMAND (command));
			
			g_free (line);
			
			anjuta_command_notify_data_arrived (command);
		}
	}
	
	apr_file_close (diff_file);
	
	return 0;
								 
}

static void
svn_diff_command_class_init (SvnDiffCommandClass *klass)
{
	GObjectClass* object_class = G_OBJECT_CLASS (klass);
	AnjutaCommandClass *command_class = ANJUTA_COMMAND_CLASS (klass);

	object_class->finalize = svn_diff_command_finalize;
	command_class->run = svn_diff_command_run;
}

SvnDiffCommand *
svn_diff_command_new (gchar *path, glong revision1, glong revision2, 
					  gboolean recursive)
{
	SvnDiffCommand *self;
	
	self = g_object_new (SVN_TYPE_DIFF_COMMAND, NULL);
	self->priv->path = g_strdup (path);
	self->priv->revision1 = revision1;
	self->priv->revision2 = revision2;
	self->priv->recursive = recursive;
	
	return self;
}

void
svn_diff_command_destroy (SvnDiffCommand *self)
{
	g_object_unref (self);
}

GQueue *
svn_diff_command_get_output (SvnDiffCommand *self)
{
	return self->priv->output;
}