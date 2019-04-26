﻿/*
Company: OptimaJet
Project: WorkflowEngine.NET Provider for Oracle
Version: 3.1
File: update_3_1.sql
*/
-- WORKFLOWPROCESSCHEME
declare
index_not_exists EXCEPTION;
PRAGMA EXCEPTION_INIT(index_not_exists, -1418);
begin

    execute immediate 'DROP INDEX IDX_WORKFLOWPROCESSSCHEME_SCHE';
exception
    when index_not_exists then null;
end;

ALTER TABLE WORKFLOWPROCESSSCHEME MODIFY DEFININGPARAMETERSHASH NVARCHAR2(24);

CREATE INDEX IDX_WORKFLOWPROCESSSCHEME_SCHE ON WORKFLOWPROCESSSCHEME (SCHEMECODE,DEFININGPARAMETERSHASH, ISOBSOLETE)
LOGGING;

-- WORKFLOWPROCESSINSTANCE
declare
index_not_exists EXCEPTION;
PRAGMA EXCEPTION_INIT(index_not_exists, -1418);
begin

    execute immediate 'DROP INDEX IDX_WORKFLOWPROCESSINSTANCE_SC';
exception
    when index_not_exists then null;
end;

--WORKFLOWGLOBALPARAMETER
ALTER TABLE WORKFLOWGLOBALPARAMETER MODIFY TYPE NVARCHAR2(512) DEFAULT NULL;

CREATE INDEX IDX_WORKFLOWGLOBALPARAMETER_TY ON WORKFLOWGLOBALPARAMETER (TYPE,NAME)
LOGGING;

--WORKFLOWPROCESSTRANSITIONHISTORY
CREATE INDEX IDX_WORKFLOWPROCESSTRANSITIONH_EX ON WORKFLOWPROCESSTRANSITIONH (EXECUTORIDENTITYID)
LOGGING;

--WORKFLOWPROCESSTIMER
CREATE INDEX IDX_WORKFLOWPROCESSTIMER_DATE ON WORKFLOWPROCESSTIMER (NEXTEXECUTIONDATETIME)
LOGGING;

COMMIT;