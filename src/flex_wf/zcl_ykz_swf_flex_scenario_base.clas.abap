class ZCL_YKZ_SWF_FLEX_SCENARIO_BASE definition
  public
  inheriting from CL_SWF_FLEX_IFS_DEF_APPL_BASE
  final
  create public .

public section.

  methods IF_SWF_FLEX_IFS_DEF_APPL~ON_VALIDATION_CALLBACK
    redefinition .
protected section.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_YKZ_SWF_FLEX_SCENARIO_BASE IMPLEMENTATION.


  METHOD if_swf_flex_ifs_def_appl~on_validation_callback.

    DATA(lt_all_activities) = io_workflow->get_all_activities( ).

    IF 1 = 2.
      MESSAGE e001(zykz_lx_demo_wfl).
    ENDIF.

    LOOP AT lt_all_activities REFERENCE INTO DATA(lr_activity).
      DATA(lv_index) = sy-tabix.
      DATA(lv_taskid) = lr_activity->*->get_task_id( ).
      IF lv_taskid = zcl_ykz_flex_wf_object=>gc_update_approver_list AND
        ( lv_index = 1 OR
        ( lt_all_activities[ lv_index - 1 ]->get_task_id( ) <> zcl_ykz_flex_wf_object=>gc_user_decision AND
          lt_all_activities[ lv_index - 1 ]->get_task_id( ) <> zcl_ykz_flex_wf_object=>gc_manual_approve ) ).
        RAISE EXCEPTION TYPE cx_swf_flex_ifs_exception
          EXPORTING
            t100_msg = VALUE swf_t100ms( msgid = 'ZYKZ_LX_DEMO_WFL'
                                         msgno = 001
                                         msgty = 'E' ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
