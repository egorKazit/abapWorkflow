class ZCL_YKZ_LX_DEMO_WFL_ACTIONS definition
  public
  final
  create public .

public section.

  interfaces /IWWRK/IF_WF_WI_BEFORE_UPD_IB .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YKZ_LX_DEMO_WFL_ACTIONS IMPLEMENTATION.


  METHOD /iwwrk/if_wf_wi_before_upd_ib~before_update.

    DATA:
      ls_object TYPE swr_obj_2,
      lv_wiid   TYPE sww_wiid,
      lv_note   TYPE string.

    lv_wiid = is_wi_details-wi_id.

*  Access the workflow data
    CALL FUNCTION 'SAP_WAPI_GET_OBJECTS'
      EXPORTING
        workitem_id      = lv_wiid
      IMPORTING
        leading_object_2 = ls_object.

    CASE iv_decision_key.
*  -------------------------------------------
      WHEN 0001.  " APPROVED
        DATA(lv_decision) = zcl_ykz_flex_wf_object=>gc_outcome_approved.
*  --------------------------------------------
      WHEN 0002. " REJECTED
        lv_decision = zcl_ykz_flex_wf_object=>gc_outcome_rejected.
    ENDCASE.

    DATA lt_container   TYPE STANDARD TABLE OF swr_cont.

    APPEND VALUE swr_cont( element = 'UserDecisionForManual'
                           value   = lv_decision ) TO lt_container.

    CALL FUNCTION 'SAP_WAPI_WORKITEM_COMPLETE'
      EXPORTING
        workitem_id      = lv_wiid
      TABLES
        simple_container = lt_container.

  ENDMETHOD.
ENDCLASS.
