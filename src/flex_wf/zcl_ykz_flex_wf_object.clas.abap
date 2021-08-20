CLASS zcl_ykz_flex_wf_object DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES bi_object .
    INTERFACES bi_persistent .
    INTERFACES if_workflow .

    DATA ms_header TYPE zykzirhdr .
    DATA mv_key_in_string TYPE string.
    CONSTANTS gc_reject_event TYPE swc_elem VALUE 'REJECT' ##NO_TEXT.
    CONSTANTS gc_approve_event TYPE swc_elem VALUE 'APPROVE' ##NO_TEXT.
    CONSTANTS gc_user_decision TYPE string VALUE 'TS99900004' ##NO_TEXT.
    CONSTANTS gc_manual_approve TYPE string VALUE 'TS99900001' ##NO_TEXT.
    CONSTANTS gc_update_approver_list TYPE string VALUE 'TS99900003' ##NO_TEXT.
    CONSTANTS gc_outcome_rejected TYPE string VALUE 'REJECTED' ##NO_TEXT.
    CONSTANTS gc_outcome_approved TYPE string VALUE 'APPROVED' ##NO_TEXT.

    EVENTS submit
      EXPORTING
        VALUE(iv_object_key) TYPE swc_elem OPTIONAL .
    EVENTS reject
      EXPORTING
        VALUE(iv_agent) TYPE swp_agent
        VALUE(iv_decision) TYPE swc_elem .
    EVENTS approve
      EXPORTING
        VALUE(iv_agent) TYPE swp_agent
        VALUE(iv_decision) TYPE swc_elem .
    EVENTS withdraw .
    EVENTS rework_done .
    EVENTS sent_back .

    METHODS constructor
      IMPORTING
        VALUE(iv_inst_key) TYPE uuid OPTIONAL .
    METHODS start_workflow
      RETURNING
        VALUE(rv_is_success) TYPE abap_bool .
    METHODS cancel_workflow
      RETURNING
        VALUE(rv_is_success) TYPE abap_bool .
    METHODS handle_user_manual_approve
      IMPORTING
        !iv_event            TYPE swc_elem
      RETURNING
        VALUE(rv_is_success) TYPE abap_bool .
    METHODS automatic_approve .
    METHODS manual_approve .
    METHODS send_notification .
    METHODS perform_approve
      IMPORTING
        !iv_is_final      TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(ri_message) TYPE REF TO /bobf/if_frw_message .
    METHODS perform_reject
      RETURNING
        VALUE(ri_message) TYPE REF TO /bobf/if_frw_message .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA m_por TYPE sibflpor .
    CONSTANTS gc_objcateg TYPE sibfcatid VALUE 'CL' ##NO_TEXT.
    CONSTANTS gc_objtype TYPE sibftypeid VALUE 'ZCL_YKZ_FLEX_WF_OBJECT' ##NO_TEXT.
    CONSTANTS gc_submit_event TYPE swc_elem VALUE 'SUBMIT' ##NO_TEXT.
    CONSTANTS gc_withdraw_event TYPE swc_elem VALUE 'WITHDRAW' ##NO_TEXT.
ENDCLASS.



CLASS zcl_ykz_flex_wf_object IMPLEMENTATION.


  METHOD automatic_approve.
  ENDMETHOD.


  METHOD bi_object~default_attribute_value.
  ENDMETHOD.


  METHOD bi_object~execute_default_method.
  ENDMETHOD.


  METHOD bi_object~release.
  ENDMETHOD.


  METHOD bi_persistent~find_by_lpor.
    result  = NEW zcl_ykz_flex_wf_object( iv_inst_key = CONV #( lpor-instid ) ).
  ENDMETHOD.


  METHOD bi_persistent~lpor.
    result = me->m_por.
  ENDMETHOD.


  METHOD bi_persistent~refresh.
  ENDMETHOD.


  METHOD cancel_workflow.

    rv_is_success = abap_false.

    TRY.
        DATA(lo_swf_evt_event) = cl_swf_evt_event=>get_instance(
                 im_objcateg = gc_objcateg
                 im_objtype  = gc_objtype
                 im_event    = gc_withdraw_event
                 im_objkey   = me->m_por-instid
               ).

      CATCH cx_swf_cnt_cont_access_denied cx_swf_cnt_elem_access_denied cx_swf_cnt_elem_not_found
        cx_swf_cnt_elem_type_conflict cx_swf_cnt_unit_type_conflict cx_swf_cnt_elem_def_invalid
        cx_swf_cnt_container.
        RETURN.
    ENDTRY.
    TRY.
        lo_swf_evt_event->raise( ).
      CATCH cx_swf_evt_invalid_objtype cx_swf_evt_invalid_event.
        RETURN.
    ENDTRY.

    rv_is_success = abap_true.

  ENDMETHOD.


  METHOD constructor.

    DATA lt_header TYPE ztykz_i_requestheadertp.

    /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zif_ykz_i_requestheadertp_c=>sc_bo_key )->retrieve(
                                        EXPORTING
                                          iv_node_key = zif_ykz_i_requestheadertp_c=>sc_node-zykz_i_requestheadertp
                                          it_key      = VALUE #( ( key = iv_inst_key ) )
                                        IMPORTING
                                          et_data     = lt_header ).

    ms_header = CORRESPONDING #( lt_header[ 1 ] ).

    mv_key_in_string = cl_soap_wsrmb_helper=>convert_uuid_raw_to_hyphened( iv_inst_key ).

    me->m_por-instid = iv_inst_key.
    me->m_por-catid = 'CL'.
    me->m_por-typeid = 'ZCL_YKZ_FLEX_WF_OBJECT'.

  ENDMETHOD.


  METHOD handle_user_manual_approve.

    rv_is_success = abap_false.

    TRY.
        DATA(lo_swf_evt_event) = cl_swf_evt_event=>get_instance(
                 im_objcateg = gc_objcateg
                 im_objtype  = gc_objtype
                 im_event    = iv_event
                 im_objkey   = me->m_por-instid
               ).

      CATCH cx_swf_cnt_cont_access_denied cx_swf_cnt_elem_access_denied cx_swf_cnt_elem_not_found
        cx_swf_cnt_elem_type_conflict cx_swf_cnt_unit_type_conflict cx_swf_cnt_elem_def_invalid
        cx_swf_cnt_container.
        RETURN.
    ENDTRY.
    TRY.
        lo_swf_evt_event->raise( ).
      CATCH cx_swf_evt_invalid_objtype cx_swf_evt_invalid_event INTO DATA(lo_ex).
        RETURN.
    ENDTRY.

    rv_is_success = abap_true.

  ENDMETHOD.


  METHOD manual_approve.
  ENDMETHOD.


  METHOD perform_approve.

    /bobf/cl_tra_serv_mgr_factory=>get_service_manager(
      zif_ykz_i_requestheadertp_c=>sc_bo_key
    )->do_action(
    EXPORTING
      iv_act_key              = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-approve
      it_key                  = VALUE #( ( key = CONV #( me->m_por-instid ) ) )
      is_parameters           = NEW zsykz_a_approve( iv_is_final )
    IMPORTING
      eo_message              = ri_message ).

  ENDMETHOD.


  METHOD perform_reject.

    /bobf/cl_tra_serv_mgr_factory=>get_service_manager(
      zif_ykz_i_requestheadertp_c=>sc_bo_key
    )->do_action(
    EXPORTING
      iv_act_key              = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-reject
      it_key                  = VALUE #( ( key = CONV #( me->m_por-instid ) ) )
      IMPORTING
        eo_message              = ri_message ).

  ENDMETHOD.


  METHOD send_notification.

    DATA lt_workitems TYPE STANDARD TABLE OF swr_wihdr.
    DATA lt_attachments TYPE STANDARD TABLE OF swr_object.
    DATA lt_comment_content TYPE STANDARD TABLE OF solisti1.

    DATA(lr_object) = NEW sibflporb( ).
    lr_object->instid  = m_por-instid.
    lr_object->catid   = m_por-catid.
    lr_object->objtype = m_por-objtype.
    lr_object->typeid  = m_por-typeid.

    CALL FUNCTION 'SAP_WAPI_WORKITEMS_TO_OBJECT'
      EXPORTING
        object_por = lr_object->*
      TABLES
        worklist   = lt_workitems.

    IF lt_workitems IS INITIAL.
      RETURN.
    ENDIF.

    CALL FUNCTION 'SAP_WAPI_GET_ATTACHMENTS'
      EXPORTING
        workitem_id           = lt_workitems[ 1 ]-wi_id
        language              = sy-langu " SAP System, Current Language
        comment_semantic_only = 'X'
      TABLES
        attachments           = lt_attachments.

    DATA(lr_data_to_send) = NEW zsykz_a_insert_approver( ).
    lr_data_to_send->headeruuid  = me->m_por-instid.
    lr_data_to_send->ip             = 'localhost'.

    LOOP AT lt_attachments REFERENCE INTO DATA(lr_attachment).
      DATA(lv_x) = NEW so_entryid( ).
      lv_x->* = lr_attachment->object_id+20(46).
      CALL FUNCTION 'SO_DOCUMENT_READ_API1'
        EXPORTING
          document_id                = lv_x->*
        TABLES
          object_content             = lt_comment_content
        EXCEPTIONS
          document_id_not_exist      = 1
          operation_no_authorization = 2
          x_error                    = 3
          OTHERS                     = 4.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.
      LOOP AT lt_comment_content REFERENCE INTO DATA(lr_comment_content).
        CONCATENATE lr_data_to_send->message lr_comment_content->* INTO lr_data_to_send->message.
      ENDLOOP.
    ENDLOOP.

    IF lr_data_to_send->message IS INITIAL.
      lr_data_to_send->message = 'No Content'.
    ENDIF.

    /bobf/cl_tra_serv_mgr_factory=>get_service_manager(
      zif_ykz_i_requestheadertp_c=>sc_bo_key
    )->do_action(
    EXPORTING
           iv_act_key     = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-send_notification
           it_key         = VALUE #( ( key = CONV #( me->m_por-instid ) ) )
           is_parameters  = lr_data_to_send ).
  ENDMETHOD.


  METHOD start_workflow.

    rv_is_success = abap_false.

    TRY.
        DATA(lo_swf_evt_event) = cl_swf_evt_event=>get_instance(
                 im_objcateg = gc_objcateg
                 im_objtype  = gc_objtype
                 im_event    = gc_submit_event
                 im_objkey   = me->m_por-instid
               ).

        DATA(lo_event_container) = lo_swf_evt_event->get_event_container( ).
        lo_event_container->set(
          EXPORTING
            name       = if_mm_pur_workflow_c=>gc_iv_initiator
            value      = sy-uname ).

      CATCH cx_swf_cnt_cont_access_denied cx_swf_cnt_elem_access_denied cx_swf_cnt_elem_not_found
        cx_swf_cnt_elem_type_conflict cx_swf_cnt_unit_type_conflict cx_swf_cnt_elem_def_invalid
        cx_swf_cnt_container.
        RETURN.
    ENDTRY.
    TRY.
        lo_swf_evt_event->raise( ).
      CATCH cx_swf_evt_invalid_objtype cx_swf_evt_invalid_event INTO DATA(lo_ex).
        RETURN.
    ENDTRY.

    rv_is_success = abap_true.

  ENDMETHOD.
ENDCLASS.
