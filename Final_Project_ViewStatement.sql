--Complete overview report of Bio-Sequence Exports

CREATE VIEW biosequence_exports_projection AS
	SELECT dbo.document_version.content_id, 
	       dbo.document_version.submission_id, 
		   dbo.document_version.patent_application_no, 
		   dbo.document_version.major_version_no, 
		   dbo.document_version.sequence_qtuantity, 
		   dbo.document_subversion.minor_version_no, 
		   dbo.document_subversion.last_mod_ts, 
		   dbo.document_export.export_status, 
		   dbo.document_export.export_ts, 
		   dbo.stnd_document_decision.decision_cd, 
		   dbo.stnd_bio_sequence_format.bio_sequence_format_nm, 
		   dbo.stnd_export_system.exported_system_nm, 
		   dbo.stnd_source_system.source_system_name, 
		   dbo.biosequence_user.first_name, 
		   dbo.biosequence_user.last_name
	FROM dbo.biosequence_user 
	INNER JOIN (dbo.stnd_source_system 
				INNER JOIN (dbo.stnd_export_system 
							INNER JOIN (dbo.stnd_bio_sequence_format 
										INNER JOIN (dbo.stnd_document_decision 
													INNER JOIN (dbo.document_version 
																INNER JOIN (dbo.document_subversion 
																			INNER JOIN dbo.document_export 
																			ON dbo.document_subversion.document_subversion_id = dbo.document_export.document_subversion_id) 
																ON (dbo.document_version.document_version_id = dbo.document_export.document_version_id) 
																AND (dbo.document_version.document_version_id = dbo.document_subversion.document_version_id)) 
													ON dbo.stnd_document_decision.document_decision_id = dbo.document_version.document_decision_id) 
										ON dbo.stnd_bio_sequence_format.bio_sequence_format_id = dbo.document_version.bio_sequence_format_id) 
							ON dbo.stnd_export_system.exported_system_id = dbo.document_export.exported_system_id) 
				ON dbo.stnd_source_system.source_system_id = dbo.document_version.source_system_id) 
	ON dbo.biosequence_user.bio_user_id = dbo.document_export.create_user_id;

GO

SELECT * FROM biosequence_exports_projection

---How many documents are certified or rejected in last one month
SELECT dbo.document_version.major_version_no,  dbo.stnd_document_decision.decision_cd, MAX(dbo.document_subversion.minor_version_no)
FROM (dbo.stnd_document_decision 
INNER JOIN dbo.document_version ON dbo.stnd_document_decision.document_decision_id = dbo.document_version.document_decision_id) 
INNER JOIN dbo.document_subversion ON dbo.document_version.document_version_id = dbo.document_subversion.document_version_id
GROUP BY dbo.document_version.major_version_no,  dbo.stnd_document_decision.decision_cd;

---How many documents are certified or rejected in last one month By application number
CREATE VIEW count_process_seq_by_month AS
	SELECT dbo.document_version.patent_application_no,dbo.document_version.major_version_no,  dbo.stnd_document_decision.decision_cd, MAX(dbo.document_subversion.minor_version_no) as processed_sequencelisting_no
	FROM (dbo.stnd_document_decision 
	INNER JOIN dbo.document_version ON dbo.stnd_document_decision.document_decision_id = dbo.document_version.document_decision_id) 
	INNER JOIN dbo.document_subversion ON dbo.document_version.document_version_id = dbo.document_subversion.document_version_id
	WHERE dbo.document_subversion.last_mod_ts >= DATEADD(mm,DATEDIFF(mm,0,GETDATE())-1,0) AND dbo.document_subversion.last_mod_ts >= DATEADD(mm,DATEDIFF(mm,0,GETDATE()),0)
	GROUP BY dbo.document_version.patent_application_no, dbo.document_version.major_version_no,  dbo.stnd_document_decision.decision_cd;
GO

CREATE FUNCTION dbo.count_certify_Reject_by_Last_month()
RETURNS int AS 
BEGIN
	DECLARE @returnValue int 
	SELECT @returnValue = count_process_seq_by_month.processed_sequencelisting_no FROM count_process_seq_by_month
	RETURN @returnvalue
END
Go

SELECT
dbo.count_certify_Reject_by_Last_month() as total_processed_sequence
FROM count_process_seq_by_month
Go

-- How many ST26 was loaded into system in last one year by projected year
CREATE PROCEDURE loadCountST26(@seqFormat VARCHAR(10))
AS
BEGIN
SELECT COUNT(dbo.document_version.document_version_id) as total_count_ST26, 
		dbo.stnd_bio_sequence_format.bio_sequence_format_nm, YEAR(dbo.document_version.create_ts) as projected_year
FROM dbo.stnd_bio_sequence_format 
INNER JOIN dbo.document_version ON dbo.stnd_bio_sequence_format.bio_sequence_format_id = dbo.document_version.bio_sequence_format_id
WHERE dbo.stnd_bio_sequence_format.bio_sequence_format_nm=@seqFormat
and dbo.document_version.create_ts > DATEADD(YEAR,-1, GETDATE())
GROUP BY dbo.stnd_bio_sequence_format.bio_sequence_format_nm, YEAR(dbo.document_version.create_ts);
END
Go
DECLARE @seqFormat VARCHAR(10)
SET @seqFormat = 'ST26'
EXEC loadCountST26 @seqFormat

-- How many certified sequencelisting have been exported to ABSS after march 1st 2019.
CREATE FUNCTION dbo.exported_seq_from_date(@fromDate DATETIME, @exportedSystem VARCHAR(10))
RETURNS int AS 
BEGIN
	DECLARE @returnValue int 
	SELECT @returnValue = COUNT(*) FROM biosequence_exports_projection 
	WHERE dbo.biosequence_exports_projection.exported_system_nm = @exportedSystem and dbo.biosequence_exports_projection.export_ts >= @fromDate
	RETURN @returnvalue
END
Go
DECLARE @fromDate DATETIME
SET @fromDate = '2019-03-01'
DECLARE @exportedSystem VARCHAR(10)
SET @exportedSystem = 'ABBSS'
SELECT
dbo.exported_seq_from_date(@fromDate, @exportedSystem) as total_abbss_exported_sequence
FROM count_process_seq_by_month
Go

--How many sequencelisting header have been edited in last one year

CREATE PROCEDURE editHeaderSequenceListingCount(@minorVer int)
AS
BEGIN
SELECT COUNT(dbo.document_subversion.document_subversion_id) as total_no_edited_sequencelisting
FROM dbo.document_subversion 
WHERE dbo.document_subversion.minor_version_no = @minorVer
and dbo.document_subversion.create_ts > DATEADD(WEEK,-8, GETDATE())
END
Go
DECLARE @minorVer int
SET @minorVer = '2'
EXEC editHeaderSequenceListingCount @minorVer


-- Provide the list of the sequencelisting or total count of sequencelisting are in the system have not been reviewed yet where sequencelisting is loaded after Jan 1, 2019
CREATE VIEW unprocessedSequenceListing AS
SELECT * FROM dbo.document_version where document_decision_id IS NULL
Go

CREATE PROCEDURE unprocessedSequenceListingProc(@afterDate DATETIME)
AS
BEGIN
SELECT * from unprocessedSequenceListing WHERE unprocessedSequenceListing.create_ts >= @afterDate
END
Go
DECLARE @afterDate DATETIME
SET @afterDate = '2019-01-01'
EXEC unprocessedSequenceListingProc @afterDate