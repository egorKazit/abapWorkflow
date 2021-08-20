class ZCL_ZYKZ_C_REQUESTHEAD_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
   TS_I_DRAFTADMINISTRATIVEDATATY type I_DRAFTADMINISTRATIVEDATA .
  types:
   TT_I_DRAFTADMINISTRATIVEDATATY type standard table of TS_I_DRAFTADMINISTRATIVEDATATY .
  types:
    begin of TS_ZYKZ_C_ITEMREQUISITIONTPTYP.
      include type ZYKZCRIRQNTP.
  types:
      ACTIVEUUID type ZYKZ_LX_RIRQSTND-ACTIVEUUID,
      DRAFTENTITYCREATIONDATETIME type ZYKZ_LX_RIRQSTND-DRAFTENTITYCREATIONDATETIME,
      DRAFTENTITYLASTCHANGEDATETIME type ZYKZ_LX_RIRQSTND-DRAFTENTITYLASTCHANGEDATETIME,
      HASACTIVEENTITY type SDRAFT_HAS_ACTIVE,
      HASDRAFTENTITY type SDRAFT_HAS_DRAFT,
      ISACTIVEENTITY type SDRAFT_IS_ACTIVE,
      A_PREPARATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_VALIDATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
    end of TS_ZYKZ_C_ITEMREQUISITIONTPTYP .
  types:
   TT_ZYKZ_C_ITEMREQUISITIONTPTYP type standard table of TS_ZYKZ_C_ITEMREQUISITIONTPTYP .
  types:
    begin of TS_ZYKZ_C_REQUESTHEADERTPTYPE.
      include type ZYKZCRHDRTP.
  types:
      ACTIVEUUID type ZYKZ_LX_REQUESTD-ACTIVEUUID,
      DRAFTENTITYCREATIONDATETIME type ZYKZ_LX_REQUESTD-DRAFTENTITYCREATIONDATETIME,
      DRAFTENTITYLASTCHANGEDATETIME type ZYKZ_LX_REQUESTD-DRAFTENTITYLASTCHANGEDATETIME,
      HASACTIVEENTITY type SDRAFT_HAS_ACTIVE,
      HASDRAFTENTITY type SDRAFT_HAS_DRAFT,
      ISACTIVEENTITY type SDRAFT_IS_ACTIVE,
      A_ACTIVATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_APPROVE type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_COMPLETE type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_EDIT type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_PREPARATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_REJECT type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_SEND_NOTIFICATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_SUBMIT type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_VALIDATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_WITHDRAW type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_ZYKZ_C_REQUESTHEADERTPTYPE .
  types:
   TT_ZYKZ_C_REQUESTHEADERTPTYPE type standard table of TS_ZYKZ_C_REQUESTHEADERTPTYPE .
  types:
    begin of TS_ZYKZ_C_REQUESTITEMTPTYPE.
      include type ZYKZCRITMTP.
  types:
      ACTIVEUUID type ZYKZ_LX_REQITEMD-ACTIVEUUID,
      DRAFTENTITYCREATIONDATETIME type ZYKZ_LX_REQITEMD-DRAFTENTITYCREATIONDATETIME,
      DRAFTENTITYLASTCHANGEDATETIME type ZYKZ_LX_REQITEMD-DRAFTENTITYLASTCHANGEDATETIME,
      HASACTIVEENTITY type SDRAFT_HAS_ACTIVE,
      HASDRAFTENTITY type SDRAFT_HAS_DRAFT,
      ISACTIVEENTITY type SDRAFT_IS_ACTIVE,
      A_PREPARATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_VALIDATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
    end of TS_ZYKZ_C_REQUESTITEMTPTYPE .
  types:
   TT_ZYKZ_C_REQUESTITEMTPTYPE type standard table of TS_ZYKZ_C_REQUESTITEMTPTYPE .
  types:
   TS_ZYKZ_C_REQUESTNOTIFICATIONT type ZYKZCRNTF .
  types:
   TT_ZYKZ_C_REQUESTNOTIFICATIONT type standard table of TS_ZYKZ_C_REQUESTNOTIFICATIONT .
  types:
   TS_ZYKZ_C_REQUESTSTATUSVHTYPE type ZYKZCRSTS .
  types:
   TT_ZYKZ_C_REQUESTSTATUSVHTYPE type standard table of TS_ZYKZ_C_REQUESTSTATUSVHTYPE .

  constants GC_I_DRAFTADMINISTRATIVEDATATY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_DraftAdministrativeDataType' ##NO_TEXT.
  constants GC_ZYKZ_C_ITEMREQUISITIONTPTYP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZYKZ_C_ItemRequisitionTPType' ##NO_TEXT.
  constants GC_ZYKZ_C_REQUESTHEADERTPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZYKZ_C_RequestHeaderTPType' ##NO_TEXT.
  constants GC_ZYKZ_C_REQUESTITEMTPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZYKZ_C_RequestItemTPType' ##NO_TEXT.
  constants GC_ZYKZ_C_REQUESTNOTIFICATIONT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZYKZ_C_RequestNotificationType' ##NO_TEXT.
  constants GC_ZYKZ_C_REQUESTSTATUSVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ZYKZ_C_RequestStatusVHType' ##NO_TEXT.

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS ZCL_ZYKZ_C_REQUESTHEAD_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'ZYKZ_C_REQUESTHEADERTP_SRV' ).

define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    TRY.
        if_sadl_gw_model_exposure_data~get_model_exposure( )->expose( model )->expose_vocabulary( vocab_anno_model ).
      CATCH cx_sadl_exposure_error INTO DATA(lx_sadl_exposure_error).
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_med_exception
          EXPORTING
            previous = lx_sadl_exposure_error.
    ENDTRY.
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210713222539'.                  "#EC NOTEXT
 DATA: lv_rds_last_modified TYPE timestamp .
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
 lv_rds_last_modified =  GET_LAST_MODIFIED_RDS_4( ).
 IF rv_last_modified LT lv_rds_last_modified.
 rv_last_modified  = lv_rds_last_modified .
 ENDIF .
  endmethod.


  method GET_LAST_MODIFIED_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210713202542'.
    TRY.
        rv_last_modified_rds = CAST cl_sadl_gw_model_exposure( if_sadl_gw_model_exposure_data~get_model_exposure( ) )->get_last_modified( ).
      CATCH cx_root.
        rv_last_modified_rds = co_gen_date_time.
    ENDTRY.
    IF rv_last_modified_rds < co_gen_date_time.
      rv_last_modified_rds = co_gen_date_time.
    ENDIF.
  endmethod.


  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210713202542'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="ZYKZ_C_ITEMREQUISITIONTP" binding="ZYKZ_C_ITEMREQUISITIONTP" />|  &
               | <sadl:dataSource type="CDS" name="ZYKZ_C_REQUESTITEMTP" binding="ZYKZ_C_REQUESTITEMTP" />|  &
               | <sadl:dataSource type="CDS" name="ZYKZ_C_REQUESTNOTIFICATION" binding="ZYKZ_C_REQUESTNOTIFICATION" />|  &
               | <sadl:dataSource type="CDS" name="ZYKZ_C_REQUESTSTATUSVH" binding="ZYKZ_C_REQUESTSTATUSVH" />|  &
               | <sadl:dataSource type="CDS" name="ZYKZ_C_REQUESTHEADERTP" binding="ZYKZ_C_REQUESTHEADERTP" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="ZYKZ_C_ItemRequisitionTP" dataSource="ZYKZ_C_ITEMREQUISITIONTP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_REQUESTHEADERTP" binding="_REQUESTHEADERTP" target="ZYKZ_C_RequestHeaderTP" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_REQUESTITEMTP" binding="_REQUESTITEMTP" target="ZYKZ_C_RequestItemTP" cardinality="zeroToOne" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZYKZ_C_RequestItemTP" dataSource="ZYKZ_C_REQUESTITEMTP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_ITEMREQUISITIONTP" binding="_ITEMREQUISITIONTP" target="ZYKZ_C_ItemRequisitionTP" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_REQUESTHEADERTP" binding="_REQUESTHEADERTP" target="ZYKZ_C_RequestHeaderTP" cardinality="zeroToOne" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZYKZ_C_RequestNotification" dataSource="ZYKZ_C_REQUESTNOTIFICATION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZYKZ_C_RequestStatusVH" dataSource="ZYKZ_C_REQUESTSTATUSVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ZYKZ_C_RequestHeaderTP" dataSource="ZYKZ_C_REQUESTHEADERTP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_REQUESTITEMTP" binding="_REQUESTITEMTP" target="ZYKZ_C_RequestItemTP" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_REQUESTNOTIFICATION" binding="_REQUESTNOTIFICATION" target="ZYKZ_C_RequestNotification" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_REQUESTSTATUSVH" binding="_REQUESTSTATUSVH" target="ZYKZ_C_RequestStatusVH" cardinality="one" />|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( 'ZYKZ_C_REQUESTHEADERTP' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.
