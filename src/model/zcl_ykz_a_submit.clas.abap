CLASS zcl_ykz_a_submit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /bobf/if_frw_action.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_YKZ_A_SUBMIT IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    DATA lt_header TYPE ztykz_i_requestheadertp.

    io_read->retrieve( EXPORTING
                         iv_node       = is_ctx-node_key
                         it_key        = it_key
                       IMPORTING
                         et_data       = lt_header
                         eo_message    = eo_message
                         et_failed_key = et_failed_key ).

    CHECK lt_header IS NOT INITIAL.

    DATA(lt_modification) = NEW /bobf/t_frw_modification( ).

    LOOP AT lt_header REFERENCE INTO DATA(lr_header).

      ASSERT lr_header->isactiveentity IS NOT INITIAL.

      INSERT lr_header->* INTO TABLE et_data.

      IF NEW zcl_ykz_flex_wf_object( lr_header->key )->start_workflow( ) <> abap_true.
        CONTINUE.
      ENDIF.

      lr_header->requeststatus = zif_ykz_constants=>sc_status-header-in_approval.
      INSERT VALUE #( node           = is_ctx-node_key
                      key            = lr_header->key
                      change_mode    = /bobf/if_frw_c=>sc_modify_update
                      changed_fields = VALUE #( ( zif_ykz_i_requestheadertp_c=>sc_node_attribute-zykz_i_requestheadertp-requeststatus ) )
                      data           = lr_header ) INTO TABLE lt_modification->*.

    ENDLOOP.

    io_modify->do_modify( lt_modification->* ).
    io_modify->end_modify( ).

  ENDMETHOD.


  METHOD /bobf/if_frw_action~prepare.
  ENDMETHOD.


  METHOD /bobf/if_frw_action~retrieve_default_param.
  ENDMETHOD.
ENDCLASS.
