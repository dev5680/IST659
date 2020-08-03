/*
Author : Debasis Chatterjee
Course : IST659 M403
Term   : March 28, 2019
*/

--CREATE DATABASE [BIOSEQ]
--GO

-- Insert into biosequence_user
INSERT INTO biosequence_user 
	(patron_id, first_name, last_name, email_id) VALUES
	('312312', 'Debasis', 'Chatterjee', 'dchatter@syr.edu')
GO
INSERT INTO biosequence_user 
	(patron_id, first_name, last_name, email_id) VALUES
	('312313', 'Dale',      'Thompson', 'edthomps@syr.edu')
GO
INSERT INTO biosequence_user 
	(patron_id, first_name, last_name, email_id) VALUES
	('312314', 'Kimberly', 'Pendelberry', 'kpendelb@syr.edu')
GO
INSERT INTO biosequence_user 
	(patron_id, first_name, last_name, email_id) VALUES
	('312315', 'Abdullah', 'Mamdouh', 'amawaysh@syr.edu')
GO
INSERT INTO biosequence_user 
	(patron_id, first_name, last_name, email_id) VALUES
	('312316', 'James',     'Robertson', 'jrober12@syr.edu')
GO
-- Insert into stnd_document_code
INSERT INTO stnd_document_code(document_code,    description_tx,                         begin_effective_dt, create_user_id, last_mod_user_id) values
                              ('SEQ.TXT.SUPP',   'Sequencelisting txt file for ST23/ST25','1970-01-01',       '1',   '1');
GO
INSERT INTO stnd_document_code(document_code,    description_tx,                         begin_effective_dt, create_user_id, last_mod_user_id) values
							  ('SEQ.XML.SUPP',   'Sequencelisting tXML file for ST26',     '1970-01-01',      '1',   '1');
GO

-- Insert into stnd_bio_sequence_format
INSERT INTO stnd_bio_sequence_format (bio_sequence_format_nm, description_tx,        begin_effective_dt, create_user_id, last_mod_user_id) values
									 ('ST23',                 'Sequence Listing 23', '1970-01-01',       '1',            '1');
GO
INSERT INTO stnd_bio_sequence_format (bio_sequence_format_nm, description_tx,        begin_effective_dt, create_user_id, last_mod_user_id) values
									 ('ST25',                 'Sequence Listing 25', '1970-01-01',       '1',            '1');
GO
INSERT INTO stnd_bio_sequence_format (bio_sequence_format_nm, description_tx,        begin_effective_dt, create_user_id, last_mod_user_id) values
									 ('ST26',                 'Sequence Listing 26', '1970-01-01',       '1',            '1');
GO

-- Insert into stnd_document_decision
INSERT INTO stnd_document_decision (decision_cd, description_tx,                      begin_effective_dt, create_user_id, last_mod_user_id) values
                                   ('CRFE',      'COMPUTER READABLE FORMAT EFFECTIVE','1970-01-01',       '1',            '1');
GO
INSERT INTO stnd_document_decision (decision_cd, description_tx,                      begin_effective_dt, create_user_id, last_mod_user_id) values
                                   ('CRFD',      'COMPUTER READABLE FORMAT DEFFERED','1970-01-01',       '1',            '1');
GO
-- Insert into stnd_source_system
INSERT INTO stnd_source_system (source_system_name, description_tx,                     begin_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('EFSWEB',           'ELECTRONIC FILING SYSTEM',         '1970-01-01',       '1',            '1')
GO
INSERT INTO stnd_source_system (source_system_name, description_tx,                     begin_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('SLIC',             'SEQUENCELISTING CONTROL',          '1970-01-01',       '1',            '1')
GO
INSERT INTO stnd_source_system (source_system_name, description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('POWER',            'PATENT POWER',                     '1970-01-01',       '2030-12-31',     '1',            '1')
GO
INSERT INTO stnd_source_system (source_system_name, description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('IB',               'INTERNATIONAL BUREAU',             '1970-01-01',       '2030-12-31',     '1',            '1')
GO
-- Insert into stnd_export_system
INSERT INTO stnd_export_system (exported_system_nm,  description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('IDC',               'INITIAL DATA CAPTURE',             '1970-01-01',       '2030-12-31',     '1',            '1')
GO
INSERT INTO stnd_export_system (exported_system_nm,  description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('FDC',               'FINAL DATA CAPTURE',             '1970-01-01',       '2030-12-31',     '1',            '1')
GO
INSERT INTO stnd_export_system (exported_system_nm,  description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('PGC',               'INTERNATIONAL BUREAU',             '1970-01-01',       '2030-12-31',     '1',            '1')
GO
INSERT INTO stnd_export_system (exported_system_nm,  description_tx,                     begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('PPD',               'PROJECTED PUBLICATION DATE',       '1970-01-01',       '2030-12-31',     '1',            '1')
GO
INSERT INTO stnd_export_system (exported_system_nm,  description_tx,                                      begin_effective_dt, end_effective_dt, create_user_id, last_mod_user_id) VALUES
                               ('ABBSS',               'AUTOMATED BIOTECHNOLOGY SEQUENCE SEARCH SYSTEM',  '1970-01-01',       '2030-12-31',     '1',            '1')
GO
-- Insert into document_version-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO document_version (content_id, bio_sequence_format_id, source_system_id, submission_id, submission_timestamp, document_code_id, patent_application_no, document_decision_id, major_version_no, sequence_qtuantity, create_user_id, create_ts,   last_mod_ts, last_mod_user_id) VALUES
                             ('cd123456','1',                      '1',              's0091827123', '2018-12-28',         '1',              '14289012',            '1',                  '1',              '102',              '2',           '2019-01-31','2019-01-31','2'            )
GO
--need to correct the document_code_id to 1
INSERT INTO document_version (content_id, bio_sequence_format_id, source_system_id, submission_id, submission_timestamp, document_code_id, patent_application_no, document_decision_id, major_version_no, sequence_qtuantity, create_user_id, create_ts,   last_mod_ts, last_mod_user_id) VALUES
                             ('cd12345a','2',                      '2',              's0091827124', '2019-01-15',        '2',              '16000178',            '2',                  '1',              '32189',            '5',           '2019-03-21','2019-03-21','5'            )
GO
INSERT INTO document_version (content_id, bio_sequence_format_id, source_system_id, submission_id, submission_timestamp, document_code_id, patent_application_no, major_version_no, sequence_qtuantity, create_user_id, create_ts,   last_mod_ts, last_mod_user_id) VALUES
                             ('cd12345b','3',                      '2',              's0091827125','2019-01-15',         '2',              '16000178',            '2',              '7675655',         '5',             '2019-03-25','2019-03-25','5'            )
GO
INSERT INTO document_version (content_id, bio_sequence_format_id, source_system_id, submission_id, submission_timestamp, document_code_id, patent_application_no, document_decision_id, major_version_no, sequence_qtuantity, create_user_id, create_ts,   last_mod_ts, last_mod_user_id) VALUES
                             ('cd12345c','3',                      '3',              's0091827127', '2017-05-23',        '2',              '62064677',            '1',                  '1',              '18',               '1',           '2019-02-28', '2019-02-28','1'            )
GO
-- Insert into document_subversion--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('1',                 '0',              '2019-01-31', '2019-01-31', '2')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('1',                 '1',              '2019-02-01', '2019-02-01', '3')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('1',                 '2',              '2019-02-01', '2019-02-01', '3')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('2',                 '0',              '2019-03-21', '2019-03-21', '5')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('2',                 '1',              '2019-03-22', '2019-03-21', '5')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('3',                 '0',              '2019-03-25', '2019-03-25', '4')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('4',                 '0',              '2019-02-28', '2019-02-28', '1')
GO
INSERT INTO document_subversion (document_version_id, minor_version_no, create_ts,    last_mod_ts,  last_mod_user_id) VALUES
                                ('4',                 '1',              '2019-02-28', '2019-02-28', '2')
GO
-- Insert into document_export-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('1' ,                '11',                    '5',                '1',           '2019-02-02',  '2019-02-02', '3',            '2019-02-02','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('1' ,                '11',                    '1',                '1',           '2019-03-02',  '2019-03-02', '3',            '2019-03-02','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('1' ,                '11',                    '2',                '1',           '2019-03-03',  '2019-03-03', '3',            '2019-03-03','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('4' ,                '16',                    '5',                '1',           '2019-03-01',  '2019-03-01', '3',            '2019-03-01','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('4' ,                '16',                    '2',                '1',           '2019-03-25',  '2019-03-25', '3',            '2019-03-25','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('4' ,                '16',                    '3',                '1',           '2019-03-26',  '2019-03-26', '3',            '2019-03-26','3'             )
GO
INSERT INTO document_export (document_version_id, document_subversion_id, exported_system_id, export_status, export_ts,     create_ts,    create_user_id, last_mod_ts, last_mod_user_id) VALUES
                            ('4' ,                '16',                    '4',                '1',           '2019-03-28',  '2019-03-28', '3',            '2019-03-28','3'             )
GO