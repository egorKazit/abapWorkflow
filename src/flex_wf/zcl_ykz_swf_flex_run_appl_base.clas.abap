CLASS zcl_ykz_swf_flex_run_appl_base DEFINITION
  PUBLIC
  INHERITING FROM cl_swf_flex_ifs_run_appl_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS if_swf_flex_ifs_run_appl_step~after_completion_callback
        REDEFINITION .
    METHODS if_swf_flex_ifs_run_appl~result_callback
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ykz_swf_flex_run_appl_base IMPLEMENTATION.


  METHOD if_swf_flex_ifs_run_appl_step~after_completion_callback.
    DATA: lv_dec_comments TYPE string,
          ls_head_attach  TYPE swr_att_header.

    DATA(lv_task_id) = io_current_activity->get_task_id( ).
    TRY.
        DATA(ls_por) = io_context->get_leading_object_reference( ).
        DATA(lo_object) = NEW zcl_ykz_flex_wf_object( CONV #( ls_por-instid ) ).
        IF lv_task_id = zcl_ykz_flex_wf_object=>gc_user_decision.
          DATA(lt_exec_result) = io_current_activity->get_execution_results( ).
          IF line_exists( lt_exec_result[ result = zcl_ykz_flex_wf_object=>gc_outcome_approved ] ).
            lo_object->perform_approve( ).
          ELSEIF line_exists( lt_exec_result[ result = zcl_ykz_flex_wf_object=>gc_outcome_rejected ] ).
            lo_object->perform_reject( ).
          ENDIF.
          /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( )->save( ).

        ELSEIF lv_task_id = zcl_ykz_flex_wf_object=>gc_manual_approve.
          DATA(lv_result) = NEW wfsyst-result( ).
          lo_object = NEW zcl_ykz_flex_wf_object( CONV #( ls_por-instid ) ).
          io_context->get_workflow_container( )->get( EXPORTING
                                                        name  = 'UserDecisionForManual'
                                                      IMPORTING
                                                        value = lv_result->* ).
          IF lv_result->* = zcl_ykz_flex_wf_object=>gc_outcome_approved.
            lo_object->perform_approve( ).
          ELSEIF line_exists( lt_exec_result[ result = zcl_ykz_flex_wf_object=>gc_outcome_rejected ] ).
            lo_object->perform_reject( ).
          ENDIF.
          /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( )->save( ).



        ELSEIF lv_task_id = zcl_ykz_flex_wf_object=>gc_update_approver_list.


        ENDIF.

      CATCH /iwngw/cx_notification_api
        cx_swf_flex_ifs_run_exception
        cx_swf_cnt_elem_not_found
        cx_swf_cnt_unit_type_conflict
        cx_swf_cnt_container
        /bobf/cx_frw_contrct_violation INTO DATA(lo_cx).

    ENDTRY.
  ENDMETHOD.


  METHOD if_swf_flex_ifs_run_appl~result_callback.

    DATA(ls_por) = io_context->get_leading_object_reference( ).
    DATA(ls_result) = io_result->get_result( ).

    DATA(lo_object) = NEW zcl_ykz_flex_wf_object( CONV #( ls_por-instid ) ).
    IF ls_result-result = zcl_ykz_flex_wf_object=>gc_outcome_approved.
      lo_object->perform_approve( abap_true ).
    ELSE.
      lo_object->perform_reject( ).
    ENDIF.
    /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( )->save( ).

  ENDMETHOD.

ENDCLASS.
