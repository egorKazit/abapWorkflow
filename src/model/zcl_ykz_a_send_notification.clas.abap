CLASS zcl_ykz_a_send_notification DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES /bobf/if_frw_action.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_YKZ_A_SEND_NOTIFICATION IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.
*    TRY.
*        DATA(ls_import_structure) = CAST zsykz_a_insert_approver( is_parameters ).
*        zcl_ykz_lx_demo_awe_sender=>zif_ykz_lx_demo_awe_sender~get_instance(
*          )->send( |headeruuid:{ ls_import_structure->headeruuid }, ip:{ ls_import_structure->ip }, message:{ ls_import_structure->message }| ).
*      CATCH cx_apc_error INTO DATA(lo_error).
*
*    ENDTRY.

    DATA(ls_parameters) = CAST zsykz_a_insert_approver( is_parameters ).
    DATA(lv_parameters) = |headeruuid:{ ls_parameters->headeruuid }, ip:{ ls_parameters->ip }, message:{ ls_parameters->message }|.
    CALL FUNCTION 'ZYKZ_LX_DEMO_SEND_NOTIFICAION'
      IN BACKGROUND TASK
      AS SEPARATE UNIT
      DESTINATION 'NONE'
      EXPORTING
        i_parameters = lv_parameters.

  ENDMETHOD.


  METHOD /bobf/if_frw_action~prepare.

  ENDMETHOD.


  METHOD /bobf/if_frw_action~retrieve_default_param.

  ENDMETHOD.
ENDCLASS.
