class ZCL_YKZ_LX_DEMO_WORKITEM_EXIT definition
  public
  final
  create public .

public section.

  interfaces IF_SWF_IFS_WORKITEM_EXIT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YKZ_LX_DEMO_WORKITEM_EXIT IMPLEMENTATION.


  METHOD if_swf_ifs_workitem_exit~event_raised.

*    DATA(lo_container) = im_workitem_context->get_wi_container( ).
*    TRY.
*        CASE im_event_name.
*          WHEN if_swf_ifs_workitem_exit~c_evttyp_after_execution.
*            lo_container->set( name       = 'LastApprover'
*                               value      = sy-uname ).
*            "WHEN .
*          WHEN OTHERS.
*        ENDCASE.
*      CATCH cx_swf_cnt_cont_access_denied
*            cx_swf_cnt_elem_access_denied
*        cx_swf_cnt_elem_not_found
*        cx_swf_cnt_elem_type_conflict
*        cx_swf_cnt_unit_type_conflict
*        cx_swf_cnt_elem_def_invalid
*        cx_swf_cnt_container INTO DATA(lo_exception).
*    ENDTRY.
  ENDMETHOD.
ENDCLASS.
