/*
Author : Debasis Chatterjee
Course : IST659 M403
Term   : March 20, 2019
*/

--CREATE DATABASE [BIOSEQ]
--GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='biosequence_user')
BEGIN
	DROP TABLE biosequence_user
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='stnd_document_code')
BEGIN
	DROP TABLE stnd_document_code
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='stnd_bio_sequence_format')
BEGIN
	DROP TABLE stnd_bio_sequence_format
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='stnd_document_decision')
BEGIN
	DROP TABLE stnd_document_decision
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='stnd_source_system')
BEGIN
	DROP TABLE stnd_source_system
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='stnd_export_system')
BEGIN
	DROP TABLE stnd_export_system
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='document_version')
BEGIN
	DROP TABLE document_version
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='document_subversion')
BEGIN
	DROP TABLE document_subversion
END
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='document_export')
BEGIN
	DROP TABLE document_export
END
GO

-- Creating the BioSequence User Table
CREATE TABLE biosequence_user(
	-- Columns for the user table
	bio_user_id int identity,
	patron_id	varchar(50) not null,
	first_name	varchar(50) not null,
	last_name	varchar(50) not null,
	email_id	varchar(50),
	-- Constraints on the User Table
	CONSTRAINT pk_biosequence_user PRIMARY KEY (bio_user_id),
	CONSTRAINT u1_biosequence_user UNIQUE(patron_id),
	CONSTRAINT u2_biosequence_user UNIQUE(email_id)
)
GO

CREATE TABLE stnd_document_code(
    document_code_id      int identity,
    document_code         varchar(25)      NOT NULL,
    description_tx        varchar(255),
    begin_effective_dt    datetime         NOT NULL,
    end_effective_dt      datetime,
    create_ts             datetime         DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id        int			   NOT NULL,
    last_mod_ts           datetime         DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id      int			   NOT NULL,
    is_locked		      tinyint          DEFAULT 0 NOT NULL,
	CONSTRAINT pk_stnd_document_code  PRIMARY KEY (document_code_id),
	CONSTRAINT u1_stnd_document_code  UNIQUE (document_code),
	CONSTRAINT fk1_stnd_document_code FOREIGN KEY (create_user_id)   References biosequence_user(bio_user_id),
	CONSTRAINT fk2_stnd_document_code FOREIGN KEY (last_mod_user_id) References biosequence_user(bio_user_id)
)
GO

CREATE TABLE stnd_bio_sequence_format(
    bio_sequence_format_id    int identity,
    bio_sequence_format_nm    varchar(50)     NOT NULL,
    description_tx            varchar(255),
    begin_effective_dt        datetime        NOT NULL,
    end_effective_dt          datetime,
    create_ts                 datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id            int		      NOT NULL,
    last_mod_ts               datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id          int		      NOT NULL,
    is_locked				  tinyint         DEFAULT 0 NOT NULL,
	CONSTRAINT pk_stnd_bio_sequence_format  PRIMARY KEY (bio_sequence_format_id),
	CONSTRAINT u1_stnd_bio_sequence_format  UNIQUE (bio_sequence_format_nm),
	CONSTRAINT fk1_stnd_bio_sequence_format FOREIGN KEY (create_user_id)   References biosequence_user(bio_user_id),
	CONSTRAINT fk2_stnd_bio_sequence_format FOREIGN KEY (last_mod_user_id) References biosequence_user(bio_user_id)
)
GO

CREATE TABLE stnd_document_decision(
    document_decision_id  int identity,
	decision_cd			  varchar(4)	  NOT NULL,
    description_tx        varchar(255),
    begin_effective_dt    datetime        NOT NULL,
    end_effective_dt      datetime,
    create_ts             datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id        int		      NOT NULL,
    last_mod_ts           datetime        DEFAULT CURRENT_TIMESTAMP  NOT NULL,
    last_mod_user_id      int		      NOT NULL,
    is_locked			  tinyint         DEFAULT 0 NOT NULL,
	CONSTRAINT pk_stnd_document_decision  PRIMARY KEY (document_decision_id),
	CONSTRAINT u1_stnd_document_decision  UNIQUE (decision_cd),
	CONSTRAINT fk1_stnd_document_decision FOREIGN KEY (create_user_id)   References biosequence_user(bio_user_id),
	CONSTRAINT fk2_stnd_document_decision FOREIGN KEY (last_mod_user_id) References biosequence_user(bio_user_id)
)
GO

CREATE TABLE stnd_source_system(
    source_system_id	  int identity,
	source_system_name	  varchar(10)	  NOT NULL,
    description_tx        varchar(255),
    begin_effective_dt    datetime        NOT NULL,
    end_effective_dt      datetime,
    create_ts             datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id        int		      NOT NULL,
    last_mod_ts           datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id      int		      NOT NULL,
    is_locked			  tinyint         DEFAULT 0 NOT NULL,
	CONSTRAINT pk_stnd_source_system  PRIMARY KEY (source_system_id),
	CONSTRAINT u1_stnd_source_system  UNIQUE (source_system_name),
	CONSTRAINT fk1_stnd_source_system FOREIGN KEY (create_user_id)   References biosequence_user(bio_user_id),
	CONSTRAINT fk2_stnd_source_system FOREIGN KEY (last_mod_user_id) References biosequence_user(bio_user_id)
)
GO

CREATE TABLE stnd_export_system(
    exported_system_id	  int identity,
	exported_system_nm	  varchar(50)	  NOT NULL,
    description_tx        varchar(255),
    begin_effective_dt    datetime        NOT NULL,
    end_effective_dt      datetime,
    create_ts             datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id        int		      NOT NULL,
    last_mod_ts           datetime        DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id      int		      NOT NULL,
    is_locked			  tinyint         DEFAULT 0 NOT NULL,
	CONSTRAINT pk_stnd_export_system  PRIMARY KEY (exported_system_id),
	CONSTRAINT u1_stnd_export_system  UNIQUE (exported_system_nm),
	CONSTRAINT fk1_stnd_export_system FOREIGN KEY (create_user_id)		References biosequence_user(bio_user_id),
	CONSTRAINT fk2_stnd_export_system FOREIGN KEY (last_mod_user_id)	References biosequence_user(bio_user_id)
)
GO

CREATE TABLE document_version(
    document_version_id          int identity,
    content_id                   varchar(36)    NOT NULL,
    bio_sequence_format_id		 int			NOT NULL,
    source_system_id			 int			NOT NULL,
    submission_id                varchar(50),
    submission_timestamp		 datetime       NOT NULL,
    document_code_id			 int			NOT NULL,
    patent_application_no        varchar(17)    NOT NULL,
    document_decision_id         int,
    major_version_no             INT            DEFAULT -1 NOT NULL,
    sequence_qtuantity           INT,
    create_user_id                int		    NOT NULL,
    create_ts                    datetime       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_ts                  datetime       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id             int            NOT NULL,
    is_locked			         tinyint        DEFAULT 0 NOT NULL,
	is_deleted                   tinyint        DEFAULT 0 NOT NULL,
	CONSTRAINT pk_document_version  PRIMARY KEY (document_version_id),
	CONSTRAINT u1_document_version  UNIQUE (content_id),
	CONSTRAINT fk1_document_version FOREIGN KEY (bio_sequence_format_id)	References stnd_bio_sequence_format(bio_sequence_format_id),
	CONSTRAINT fk2_document_version FOREIGN KEY (source_system_id)			References stnd_source_system(source_system_id),
	CONSTRAINT fk3_document_version FOREIGN KEY (document_code_id)			References stnd_document_code(document_code_id),
	CONSTRAINT fk4_document_version FOREIGN KEY (document_decision_id)		References stnd_document_decision(document_decision_id),
	CONSTRAINT fk5_document_version FOREIGN KEY (create_user_id)			References biosequence_user(bio_user_id),
	CONSTRAINT fk6_document_version FOREIGN KEY (last_mod_user_id)			References biosequence_user(bio_user_id)
)
GO

CREATE TABLE document_subversion(
    document_subversion_id              int identity,
    document_version_id                 int			   NOT NULL,
    minor_version_no                    int            NOT NULL,
    create_ts                           DATETIME       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_ts                         DATETIME       DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id                    int            NOT NULL,
    is_locked							tinyint        DEFAULT 0 NOT NULL,
	is_deleted							tinyint        DEFAULT 0 NOT NULL,
	CONSTRAINT pk_document_subversion  PRIMARY KEY (document_subversion_id),
	CONSTRAINT fk1_document_subversion FOREIGN KEY (document_version_id)	References document_version(document_version_id),
	CONSTRAINT fk2_document_subversion FOREIGN KEY (last_mod_user_id)		References biosequence_user(bio_user_id)
)
GO

CREATE TABLE document_export(
    document_export_id		int identity,
	document_version_id		int			NOT NULL,
	document_subversion_id	int			NOT NULL,
	exported_system_id		int			NOT NULL,
	export_status			tinyint		NOT NULL,
	export_ts				datetime	NOT NULL,
    create_ts				datetime    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    create_user_id			int		    NOT NULL,
    last_mod_ts				datetime    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_mod_user_id		int		    NOT NULL,
    is_locked				tinyint     DEFAULT 0 NOT NULL,
	is_deleted				tinyint     DEFAULT 0 NOT NULL,
	CONSTRAINT pk_document_export  PRIMARY KEY (document_export_id),
	CONSTRAINT fk1_document_export FOREIGN KEY (document_version_id)	References document_version(document_version_id),
	CONSTRAINT fk2_document_export FOREIGN KEY (document_subversion_id)	References document_subversion(document_subversion_id),
	CONSTRAINT fk3_document_export FOREIGN KEY (exported_system_id)		References stnd_export_system(exported_system_id),
	CONSTRAINT fk4_document_export FOREIGN KEY (create_user_id)			References biosequence_user(bio_user_id),
	CONSTRAINT fk5_document_export FOREIGN KEY (last_mod_user_id)		References biosequence_user(bio_user_id),
)
GO
