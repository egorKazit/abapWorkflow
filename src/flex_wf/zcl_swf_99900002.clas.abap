CLASS ZCL_SWF_99900002 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS read_meta
      FOR TABLE FUNCTION ZSWFM_99900002.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS ZCL_SWF_99900002 IMPLEMENTATION.

  METHOD read_meta BY database function for hdb language sqlscript using  swwcntp0.
    DECLARE lv_xml clob;

    DECLARE lv__WF_INITIATOR "$ABAP.type( SWP_INITIA )";
    DECLARE lv__WF_PRIORITY "$ABAP.type( SWW_PRIO )";
    DECLARE lv__WF_VERSION "$ABAP.type( SWD_VERSIO )";
    DECLARE lv_LASTAPPROVER "$ABAP.type( SWP_AAGENT )";
    DECLARE lv_USERDECISIONFORMANUAL "$ABAP.type( SWP_CVALUE )";


    DECLARE CURSOR c_xml FOR SELECT bintostr(to_binary(data)) AS xml  FROM swwcntp0 WHERE wi_id = :wf_id ORDER BY tabix;

    FOR ls_container AS c_xml DO
      SELECT CONCAT(IFNULL(:lv_xml,''), ls_container.xml) INTO lv_xml  FROM PUBLIC.DUMMY;
    END FOR;

    lt_dataref = WITH MYTAB AS (SELECT :lv_xml as xml FROM PUBLIC.DUMMY)
      SELECT *
        FROM XMLTABLE(
          XMLNAMESPACE( 'http://www.sap.com/abapxml' AS 'asx',
                        'http://www.sap.com/abapxml/classes/global' AS  'cls' ),
          '/asx:abap/asx:heap/cls:CL_SWF_CNT_CONTAINER/CL_SWF_CNT_CONTAINER/ELMT/SWFDELMDEFXML'
          PASSING MYTAB.xml
          COLUMNS
            name nvarchar(40) PATH 'NAME',
            value_ref nvarchar(10) PATH 'VALUE/@href',
            type  nvarchar(256) PATH 'TYPE'
      ) as X;

    lt_datavalue = WITH MYTAB AS (SELECT :lv_xml as xml FROM PUBLIC.DUMMY)
      SELECT CONCAT( '#', X.value_ref ) AS value_ref, X.value
        FROM XMLTABLE(
          xmlnamespace( 'http://www.sap.com/abapxml' AS 'asx',  'http://www.sap.com/abapxml/classes/global' AS 'cls' ),
          '/asx:abap/asx:heap/*'
          PASSING MYTAB.xml
          COLUMNS
            value_ref nvarchar(10) PATH '@id',
            value nvarchar(256) PATH 'text()'
      ) as X;

    lt_simple_attr = SELECT r.name, v.value FROM :lt_dataref AS r
      LEFT OUTER JOIN :lt_datavalue AS v ON r.value_ref = v.value_ref;

* Each simple data container attribute gets selected now
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_INITIATOR FROM :lt_simple_attr WHERE name =  '_WF_INITIATOR';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_PRIORITY FROM :lt_simple_attr WHERE name =  '_WF_PRIORITY';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv__WF_VERSION FROM :lt_simple_attr WHERE name =  '_WF_VERSION';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_LASTAPPROVER FROM :lt_simple_attr WHERE name =  'LASTAPPROVER';
    END;
    BEGIN
      DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT ::SQL_ERROR_CODE,  ::SQL_ERROR_MESSAGE FROM PUBLIC.DUMMY;
      SELECT value INTO lv_USERDECISIONFORMANUAL FROM :lt_simple_attr WHERE name =  'USERDECISIONFORMANUAL';
    END;

* Merge all simple data container attributes into the result struture
    lt_result = SELECT
                  :wf_id AS WorkflowId
                  , :lv__WF_INITIATOR AS _WF_INITIATOR
                  , :lv__WF_PRIORITY AS _WF_PRIORITY
                  , :lv__WF_VERSION AS _WF_VERSION
                  , :lv_LASTAPPROVER AS LASTAPPROVER
                  , :lv_USERDECISIONFORMANUAL AS USERDECISIONFORMANUAL
                   FROM PUBLIC.DUMMY;

    RETURN :lt_result;
  ENDMETHOD.
ENDCLASS.
