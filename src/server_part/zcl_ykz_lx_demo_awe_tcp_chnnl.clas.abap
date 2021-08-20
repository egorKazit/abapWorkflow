class ZCL_YKZ_LX_DEMO_AWE_TCP_CHNNL definition
  public
  inheriting from CL_APC_TCP_EXT_STATELESS_BASE
  final
  create public .

public section.

  methods IF_APC_TCP_SERVER_CONFIG~ON_CONNECTION_SETUP
    redefinition .
  methods IF_APC_WSP_EXTENSION~ON_MESSAGE
    redefinition .
  methods IF_APC_WSP_EXTENSION~ON_START
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YKZ_LX_DEMO_AWE_TCP_CHNNL IMPLEMENTATION.


  METHOD IF_APC_TCP_SERVER_CONFIG~ON_CONNECTION_SETUP.
    " set the terminator to line feed, i.e. hex code 0A
    e_frame-frame_type = if_apc_tcp_frame_types=>co_frame_type_terminator.
    e_frame-terminator = '0A'.
  ENDMETHOD.


  METHOD if_apc_wsp_extension~on_message.
    TRY.

        DATA(lo_awe_handler)
         = zcl_ykz_lx_demo_awe_handler=>zif_ykz_lx_demo_awe_handler~get_instance( ii_message         = i_message
                                                                                  ii_message_manager = i_message_manager ).

        " handle message
        lo_awe_handler->handle_message( ).

        i_message_manager->send( lo_awe_handler->prepare_response( ) ).

      CATCH cx_apc_error INTO DATA(lx_apc_error).
        MESSAGE lx_apc_error->get_text( ) TYPE 'E'.
    ENDTRY.
  ENDMETHOD.


  method IF_APC_WSP_EXTENSION~ON_START.
  endmethod.
ENDCLASS.
