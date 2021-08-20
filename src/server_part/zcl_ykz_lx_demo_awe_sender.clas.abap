CLASS zcl_ykz_lx_demo_awe_sender DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_apc_wsp_event_handler .
    INTERFACES if_apc_wsp_event_handler_base .
    INTERFACES zif_ykz_lx_demo_awe_sender .
  PROTECTED SECTION.
private section.

  class-data GI_INSTANCE type ref to ZIF_YKZ_LX_DEMO_AWE_SENDER .
  data MV_MESSAGE type STRING .
ENDCLASS.



CLASS ZCL_YKZ_LX_DEMO_AWE_SENDER IMPLEMENTATION.


  METHOD if_apc_wsp_event_handler~on_close.
    mv_message = 'Connection closed!'.
  ENDMETHOD.


  METHOD if_apc_wsp_event_handler~on_error.
  ENDMETHOD.


  METHOD if_apc_wsp_event_handler~on_message.
    TRY.
        mv_message = i_message->get_text( ).
      CATCH cx_apc_error INTO DATA(apc_error).
        mv_message = apc_error->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_apc_wsp_event_handler~on_open.
  ENDMETHOD.


  METHOD zif_ykz_lx_demo_awe_sender~get_instance.
    IF gi_instance IS INITIAL.
      gi_instance = NEW zcl_ykz_lx_demo_awe_sender( ).
    ENDIF.
    ri_result = gi_instance.
  ENDMETHOD.


  METHOD zif_ykz_lx_demo_awe_sender~send.

    DATA(terminator) = `0A`.

    DATA(lo_client) = cl_apc_tcp_client_manager=>create(
*                     i_protocol      = co_protocol_type_tcp
                     i_host          = 'localhost'
                     i_port          = '8100'
                     i_frame         = VALUE apc_tcp_frame( frame_type = if_apc_tcp_frame_types=>co_frame_type_terminator
                                                            terminator = terminator )
                     i_event_handler = gi_instance
*                     i_ssl_id        = 'ANONYM'
                   ).

    lo_client->connect( ).

    DATA(lo_message_manager) = CAST if_apc_wsp_message_manager( lo_client->get_message_manager( ) ).
    DATA(lo_message) = CAST if_apc_wsp_message( lo_message_manager->create_message( ) ).
    DATA(binary_terminator) = CONV xstring( terminator ).
    DATA(binary_msg) = cl_abap_codepage=>convert_to( iv_message ).

    CONCATENATE binary_msg binary_terminator INTO binary_msg IN BYTE MODE.

    lo_message->set_binary( binary_msg ).
    lo_message_manager->send( lo_message ).

    WAIT FOR PUSH CHANNELS
         UNTIL me->mv_message IS NOT INITIAL.

    lo_client->close( ).

  ENDMETHOD.
ENDCLASS.
