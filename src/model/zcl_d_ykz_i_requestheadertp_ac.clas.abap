CLASS zcl_d_ykz_i_requestheadertp_ac DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_d_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_determination~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_D_YKZ_I_REQUESTHEADERTP_AC IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA  lt_requestheader      TYPE ztykz_i_requestheadertp.

    /bobf/cl_lib_draft_active=>get_instance( is_ctx-bo_key )->separate_keys(
      EXPORTING
        iv_node_key   = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        et_draft_key  = DATA(lt_draft_bopf_keys)
        et_active_key = DATA(lt_active_bopf_keys)
     ).

    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( is_context = is_ctx  io_modify = io_modify ).

    io_read->retrieve( EXPORTING iv_node = zif_ykz_i_requestheadertp_c=>sc_node-zykz_i_requestheadertp
                                 it_key  = it_key
                       IMPORTING et_data = lt_requestheader ).

    LOOP AT lt_requestheader REFERENCE INTO DATA(lr_requestheader).

      " Submit
      IF lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-in_preparation
        AND lr_requestheader->isactiveentity = abap_true.
        DATA(lv_enable) = abap_true.
      ELSE.
        lv_enable = abap_false.
      ENDIF.

      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-submit
                                              iv_key        = lr_requestheader->key
                                              iv_value      = lv_enable ).

      " Approve/Reject/Withdraw
      IF ( lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-in_approval OR
        lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-part_approved )
        AND lr_requestheader->isactiveentity = abap_true.
        lv_enable = abap_true.
      ELSE.
        lv_enable = abap_false.
      ENDIF.

      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-send_notification
                                              iv_key        = lr_requestheader->key
                                              iv_value      = lv_enable ).

      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-approve
                                              iv_key        = lr_requestheader->key
                                              iv_value      = lv_enable ).
      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-reject
                                              iv_key        = lr_requestheader->key
                                              iv_value      = lv_enable ).
      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-withdraw
                                              iv_key        = lr_requestheader->key
                                              iv_value      = lv_enable ).

      IF lr_requestheader->requeststatus > zif_ykz_constants=>sc_status-header-in_preparation.
        lv_enable = abap_true.
      ELSE.
        lv_enable = abap_false.
      ENDIF.

      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-edit
                                              iv_key        = lr_requestheader->key
                                              iv_value      = xsdbool( lv_enable = abap_false ) ).

      lo_property_helper->set_action_enabled( iv_action_key = zif_ykz_i_requestheadertp_c=>sc_action-zykz_i_requestheadertp-complete
                                              iv_key        = lr_requestheader->key
                                              iv_value      = xsdbool( lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-approved or
                                                                       lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-rejected ) ).

      lo_property_helper->set_node_update_enabled( iv_key   = lr_requestheader->key
                                                   iv_value = xsdbool( lv_enable = abap_false ) ).

      lo_property_helper->set_node_delete_enabled( iv_key   = lr_requestheader->key
                                                   iv_value = xsdbool( lv_enable = abap_false or
                                                                       lr_requestheader->requeststatus = zif_ykz_constants=>sc_status-header-completed ) ).

      lo_property_helper->set_attribute_read_only( iv_attribute_name = zif_ykz_i_requestheadertp_c=>sc_node_attribute-zykz_i_requestheadertp-requeststatus
                                                   iv_key            = lr_requestheader->key
                                                   iv_value          = abap_true ).


    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
