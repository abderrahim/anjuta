
-- FIXME: FOREIGN keys are now supported. schema should enforces them.
-- Right now the support here is disabled.

DROP TABLE IF EXISTS workspace;
CREATE TABLE workspace (workspace_id integer PRIMARY KEY AUTOINCREMENT,
                        workspace_name varchar (50) not null unique,
                        analyse_time DATE
                        );

DROP TABLE IF EXISTS project;
CREATE TABLE project (project_id integer PRIMARY KEY AUTOINCREMENT,
                      project_name varchar (50) not null unique,
                      wrkspace_id integer REFERENCES workspace (workspace_id),
                      analyse_time DATE
                      );

DROP TABLE IF EXISTS file_include;
CREATE TABLE file_include (file_include_id integer PRIMARY KEY AUTOINCREMENT,
                           file_include_type varchar (10) not null unique
                           );

DROP TABLE IF EXISTS ext_include;
CREATE TABLE ext_include (prj_id integer REFERENCES project (project_id),
                          file_incl_id integer REFERENCES file_include (file_include_id),
                          PRIMARY KEY (prj_id, file_incl_id)
                          );

DROP TABLE IF EXISTS file_ignore;
CREATE TABLE file_ignore (file_ignore_id integer PRIMARY KEY AUTOINCREMENT,
                          file_ignore_type varchar (10) unique                          
                          );

DROP TABLE IF EXISTS ext_ignore;
CREATE TABLE ext_ignore (prj_id integer REFERENCES project (project_id),
                         file_ign_id integer REFERENCES file_ignore (file_ignore_id),
                         PRIMARY KEY (prj_id, file_ign_id)
                         );

DROP TABLE IF EXISTS file;
CREATE TABLE file (file_id integer PRIMARY KEY AUTOINCREMENT,
                   file_path TEXT not null unique,
                   prj_id integer REFERENCES project (projec_id),
                   lang_id integer REFERENCES language (language_id),
                   analyse_time DATE
                   );

DROP TABLE IF EXISTS language;
CREATE TABLE language (language_id integer PRIMARY KEY AUTOINCREMENT,
                       language_name varchar (50) not null unique);

DROP TABLE IF EXISTS symbol;
CREATE TABLE symbol (symbol_id integer PRIMARY KEY AUTOINCREMENT,
                     file_defined_id integer not null REFERENCES file (file_id),
                     name varchar (256) not null,
                     file_position integer,
                     is_file_scope integer,
                     signature varchar (256),
                     returntype varchar (256),
                     scope_definition_id integer,
                     scope_id integer,
                     type_id integer REFERENCES sym_type (type_id),
                     kind_id integer REFERENCES sym_kind (sym_kind_id),
                     access_kind_id integer REFERENCES sym_access (sym_access_id),
                     implementation_kind_id integer REFERENCES sym_implementation (sym_impl_id),
                     update_flag integer default 0,
                     unique (name, file_defined_id, file_position)
                     );

DROP TABLE IF EXISTS sym_type;
CREATE TABLE sym_type (type_id integer PRIMARY KEY AUTOINCREMENT,
                   type_type varchar (256) not null,
                   type_name varchar (256) not null,
                   unique (type_type, type_name)
                   );

DROP TABLE IF EXISTS sym_kind;
CREATE TABLE sym_kind (sym_kind_id integer PRIMARY KEY AUTOINCREMENT,
                       kind_name varchar (50) not null unique
                       );

DROP TABLE IF EXISTS sym_access;
CREATE TABLE sym_access (access_kind_id integer PRIMARY KEY AUTOINCREMENT,
                         access_name varchar (50) not null unique
                         );

DROP TABLE IF EXISTS sym_implementation;
CREATE TABLE sym_implementation (sym_impl_id integer PRIMARY KEY AUTOINCREMENT,
                                 implementation_name varchar (50) not null unique
                                 );

DROP TABLE IF EXISTS heritage;
CREATE TABLE heritage (symbol_id_base integer REFERENCES symbol (symbol_id),
                       symbol_id_derived integer REFERENCES symbol (symbol_id),
                       PRIMARY KEY (symbol_id_base, symbol_id_derived)
                       );

DROP TABLE IF EXISTS scope;
CREATE TABLE scope (scope_id integer PRIMARY KEY AUTOINCREMENT,
                    scope_name varchar(256) not null,
                    type_id integer,
                    unique (scope_name, type_id)
                    );

DROP TABLE IF EXISTS version;
CREATE TABLE version (sdb_version numeric PRIMARY KEY);

DROP TABLE IF EXISTS __tmp_heritage_scope;
CREATE TABLE __tmp_heritage_scope (tmp_heritage_scope_id integer PRIMARY KEY AUTOINCREMENT,
                            symbol_referer_id integer not null,
                            field_inherits varchar(256),
                            field_struct varchar(256),
                            field_typeref varchar(256),
                            field_enum varchar(256),
                            field_union varchar(256),
                            field_class varchar(256),
                            field_namespace varchar(256)
                            );

DROP TABLE IF EXISTS __tmp_removed;
CREATE TABLE __tmp_removed (tmp_removed_id integer PRIMARY KEY AUTOINCREMENT,
                            symbol_removed_id integer not null
                            );

DROP INDEX IF EXISTS symbol_idx_3;
CREATE INDEX symbol_idx_3 ON symbol (name, file_defined_id, type_id);

DROP INDEX IF EXISTS symbol_idx_4;
CREATE INDEX symbol_idx_4 ON symbol (scope_id);

DROP INDEX IF EXISTS symbol_idx_5;
CREATE INDEX symbol_idx_5 ON symbol (type_id);

DROP TRIGGER IF EXISTS delete_file_trg;
CREATE TRIGGER delete_file_trg BEFORE DELETE ON file
FOR EACH ROW
BEGIN
	DELETE FROM symbol WHERE file_defined_id = old.file_id;
END;

DROP TRIGGER IF EXISTS delete_symbol_trg;
CREATE TRIGGER delete_symbol_trg BEFORE DELETE ON symbol
FOR EACH ROW
BEGIN
    DELETE FROM scope WHERE scope.scope_id=old.scope_definition_id;
    UPDATE symbol SET scope_id='-1' WHERE symbol.scope_id=old.scope_definition_id AND symbol.scope_id > 0;
    INSERT INTO __tmp_removed (symbol_removed_id) VALUES (old.symbol_id);
END;

PRAGMA page_size = 32768;
PRAGMA cache_size = 12288;
PRAGMA synchronous = OFF;
PRAGMA temp_store = MEMORY;
PRAGMA case_sensitive_like = 1;
PRAGMA journal_mode = OFF;
PRAGMA read_uncommitted = 1;
PRAGMA foreign_keys = OFF;
