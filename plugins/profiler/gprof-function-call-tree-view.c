/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * gprof-function-call-tree-view.c
 * Copyright (C) James Liggett 2006 <jrliggett@cox.net>
 * 
 * gprof-function-call-tree-view.c is free software.
 * 
 * You may redistribute it and/or modify it under the terms of the
 * GNU General Public License, as published by the Free Software
 * Foundation; either version 2, or (at your option) any later version.
 * 
 * plugin.c is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with plugin.c.  See the file "COPYING".  If not,
 * write to:  The Free Software Foundation, Inc.,
 *            59 Temple Place - Suite 330,
 *            Boston,  MA  02111-1307, USA.
 */

#include "gprof-function-call-tree-view.h"

struct _GProfFunctionCallTreeViewPriv
{
	GladeXML *gxml;
	GtkTreeStore *tree_store;
};

enum
{
	COL_RECURSIVE = 0,
	COL_NAME,
	NUM_COLS
};

static void
gprof_function_call_tree_view_create_columns (GProfFunctionCallTreeView *self)
{
	GtkTreeViewColumn *col;
	GtkCellRenderer *renderer;
	GtkWidget *tree_view;
	
	tree_view = glade_xml_get_widget (self->priv->gxml, 
									  "function_call_tree_view");
	
	/* Recursive icon */
	col = gtk_tree_view_column_new ();
	gtk_tree_view_append_column (GTK_TREE_VIEW (tree_view), col);
	
	renderer = gtk_cell_renderer_pixbuf_new ();
	gtk_tree_view_column_pack_start (col, renderer, TRUE);
	gtk_tree_view_column_add_attribute (col, renderer, "stock-id", COL_RECURSIVE);
	
	/* Function name */
	col = gtk_tree_view_column_new ();
	gtk_tree_view_column_set_title (col, "Function Name");
	gtk_tree_view_append_column (GTK_TREE_VIEW (tree_view), col);
	gtk_tree_view_set_expander_column (GTK_TREE_VIEW (tree_view), col);
	
	renderer = gtk_cell_renderer_text_new ();
	gtk_tree_view_column_pack_start (col, renderer, TRUE);
	gtk_tree_view_column_add_attribute (col, renderer, "text", COL_NAME);
	
	/* Model setup */
	gtk_tree_view_set_model (GTK_TREE_VIEW (tree_view), 
							 GTK_TREE_MODEL (self->priv->tree_store));
	g_object_unref (self->priv->tree_store);
}

static void 
gprof_function_call_tree_view_add_function (GProfFunctionCallTreeView *self,
											GProfCallGraph *call_graph,
											GProfCallGraphBlock *block,
											GtkTreeIter *parent_iter)
{
	GtkTreeIter child_iter;
	GList *entry_iter;
	GProfCallGraphBlockEntry *current_entry;
	GProfCallGraphBlockEntry *current_child;
	GProfCallGraphBlock *next_block;
	GProfCallGraphBlockEntry *next_block_primary_entry;
	gchar *current_entry_name;
	gchar *next_block_name;
	
	current_entry = gprof_call_graph_block_get_primary_entry (block);
	current_entry_name = gprof_call_graph_block_entry_get_name (current_entry);
	
	gtk_tree_store_append (self->priv->tree_store, &child_iter, parent_iter);
	gtk_tree_store_set (self->priv->tree_store, &child_iter, COL_NAME,
						current_entry_name, -1);
	
	if (gprof_call_graph_block_is_recursive (block))
		gtk_tree_store_set (self->priv->tree_store, &child_iter, COL_RECURSIVE,
							GTK_STOCK_REFRESH, -1);
	
	current_child = gprof_call_graph_block_get_first_child (block, &entry_iter);
	
	while (current_child)
	{
		next_block = gprof_call_graph_find_block (call_graph, 
												  gprof_call_graph_block_entry_get_name (current_child));
		current_child = gprof_call_graph_block_entry_get_next (entry_iter, 
															   &entry_iter);
		
		if (next_block)
		{
			next_block_primary_entry = gprof_call_graph_block_get_primary_entry (next_block);
			next_block_name = gprof_call_graph_block_entry_get_name (next_block_primary_entry);		
			
			/* Make sure we don't go into an infinite loop on recursive functions */
			if (strcmp(next_block_name, current_entry_name) == 0)
				continue;

			gprof_function_call_tree_view_add_function (self, call_graph, 
														next_block, &child_iter);
		}
	}
	
}

static void
gprof_function_call_tree_view_init (GProfFunctionCallTreeView *self)
{
	self->priv = g_new0 (GProfFunctionCallTreeViewPriv, 1);
	
	self->priv->gxml = glade_xml_new (PACKAGE_DATA_DIR
									  "/glade/profiler-function-call-tree.glade", 
									  NULL, NULL);
	self->priv->tree_store = gtk_tree_store_new (NUM_COLS, G_TYPE_STRING,
												 G_TYPE_STRING);
	
	gprof_function_call_tree_view_create_columns (self);
}

static void
gprof_function_call_tree_view_finalize (GObject *obj)
{
	GProfFunctionCallTreeView *self;
	
	self = (GProfFunctionCallTreeView *) obj;
	
	g_object_unref (self->priv->gxml);
	g_free (self->priv);
}

static void
gprof_function_call_tree_view_class_init (GProfFunctionCallTreeViewClass *klass)
{
	GObjectClass *object_class;
	GProfViewClass *view_class;
	
	object_class = (GObjectClass *) klass;
	view_class = GPROF_VIEW_CLASS (klass);
	
	object_class->finalize = gprof_function_call_tree_view_finalize;
	view_class->refresh = gprof_function_call_tree_view_refresh;
	view_class->get_widget = gprof_function_call_tree_view_get_widget;
}

GType
gprof_function_call_tree_view_get_type ()
{
	static GType obj_type = 0;
	
	if (!obj_type)
	{
		static const GTypeInfo obj_info = 
		{
			sizeof (GProfFunctionCallTreeViewClass),
			(GBaseInitFunc) NULL,
			(GBaseFinalizeFunc) NULL,
			(GClassInitFunc) gprof_function_call_tree_view_class_init,
			(GClassFinalizeFunc) NULL,
			NULL,           /* class_data */
			sizeof (GProfFunctionCallTreeView),
			0,              /* n_preallocs */
			(GInstanceInitFunc) gprof_function_call_tree_view_init,
			NULL            /* value_table */
		};
		obj_type = g_type_register_static (GPROF_VIEW_TYPE,
		                                   "GProfFunctionCallTreeView", 
										   &obj_info, 0);
	}
	return obj_type;
}

GProfFunctionCallTreeView *
gprof_function_call_tree_view_new (GProfProfileData *profile_data)
{
	GProfFunctionCallTreeView *view;
	
	view = g_object_new (GPROF_FUNCTION_CALL_TREE_VIEW_TYPE, NULL);
	gprof_view_set_data (GPROF_VIEW (view), profile_data);
	
	return view;
}

void
gprof_function_call_tree_view_refresh (GProfView *view)
{
	GProfFunctionCallTreeView *self;
	GProfProfileData *data;
	GProfCallGraph *call_graph;
	GProfCallGraphBlock *current_block;
	GList *root_iter;
	GtkWidget *tree_view;
	
	self = GPROF_FUNCTION_CALL_TREE_VIEW (view);
	tree_view = glade_xml_get_widget (self->priv->gxml, 
									  "function_call_tree_view");
	
	g_object_ref (self->priv->tree_store);
	
	gtk_tree_view_set_model (GTK_TREE_VIEW (tree_view), NULL);
	gtk_tree_store_clear (self->priv->tree_store);
	
	data = gprof_view_get_data (view);
	call_graph = gprof_profile_data_get_call_graph (data);
	
	current_block = gprof_call_graph_get_first_block (call_graph, &root_iter);
	
	while (current_block)
	{
		gprof_function_call_tree_view_add_function (self, call_graph, 
													current_block, NULL);
		current_block = gprof_call_graph_block_get_next(root_iter, &root_iter);
	}
	
	gtk_tree_view_set_model (GTK_TREE_VIEW (tree_view), 
							 GTK_TREE_MODEL (self->priv->tree_store));
	
	g_object_unref (self->priv->tree_store);
}

GtkWidget *
gprof_function_call_tree_view_get_widget (GProfView *view)
{
	GProfFunctionCallTreeView *self;
	
	self = GPROF_FUNCTION_CALL_TREE_VIEW (view);
	
	return glade_xml_get_widget (self->priv->gxml, 
								 "function_call_tree_scrolled");
}