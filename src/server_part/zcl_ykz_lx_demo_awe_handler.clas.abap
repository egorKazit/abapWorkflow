CLASS zcl_ykz_lx_demo_awe_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_ykz_lx_demo_awe_handler .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA gi_instance TYPE REF TO zif_ykz_lx_demo_awe_handler .
    DATA mi_message TYPE REF TO if_apc_wsp_message .
    DATA mi_message_manager TYPE REF TO if_apc_wsp_message_manager .
    CONSTANTS gc_response_code_success TYPE i VALUE 200.
    CONSTANTS gc_response_code_error TYPE i VALUE 500.
ENDCLASS.



CLASS ZCL_YKZ_LX_DEMO_AWE_HANDLER IMPLEMENTATION.


  METHOD zif_ykz_lx_demo_awe_handler~get_instance.
    IF gi_instance IS INITIAL.
      gi_instance = NEW zcl_ykz_lx_demo_awe_handler( ).
    ENDIF.
    CAST zcl_ykz_lx_demo_awe_handler( gi_instance )->mi_message         = ii_message.
    CAST zcl_ykz_lx_demo_awe_handler( gi_instance )->mi_message_manager = ii_message_manager.
    ri_result = gi_instance.
  ENDMETHOD.


  METHOD zif_ykz_lx_demo_awe_handler~handle_message.

    " retrieve the text message
    DATA(lv_text) = mi_message->get_text( ).
    DATA(lv_message_len) = strlen( lv_text ).
    lv_message_len = lv_message_len - 1.
    lv_text = lv_text+0(lv_message_len).

    DATA(lr_zykz_lx_ntfk) = NEW zykz_lx_ntfk( ).

    SPLIT lv_text AT ',' INTO TABLE DATA(lt_text).
    LOOP AT lt_text REFERENCE INTO DATA(lr_text).
      CONDENSE lr_text->*.
      SPLIT lr_text->* AT ':' INTO TABLE DATA(lt_key_val).
      ASSIGN COMPONENT lt_key_val[ 1 ] OF STRUCTURE lr_zykz_lx_ntfk->*
        TO FIELD-SYMBOL(<value>).
      IF sy-subrc = 0 AND lines( lt_key_val ) > 1.
        <value> = lt_key_val[ 2 ].
      ENDIF.
    ENDLOOP.
    lr_zykz_lx_ntfk->uuid = /bobf/cl_frw_factory=>get_new_key( ).

    MODIFY zykz_lx_ntfk FROM lr_zykz_lx_ntfk->*.

  ENDMETHOD.


  METHOD zif_ykz_lx_demo_awe_handler~prepare_response.

    " define the terminator byte, e.g. line feed as hex code
    DATA: lv_terminator TYPE xstring VALUE '0A'.
    " send 1st message
    ri_result = mi_message_manager->create_message( ).
    CASE iv_response_code.
      WHEN gc_response_code_success.
        DATA(lv_text_mesage) = |Status:{ iv_response_code },Text:Message has been successfully recieved!|.
      WHEN gc_response_code_error.
        lv_text_mesage = |Status:{ iv_response_code },Text:Recieving was failed!|.
      WHEN OTHERS.
    ENDCASE.
    " convert the text into UTF-8 byte stream
    DATA(lv_binary_message) = cl_abap_codepage=>convert_to( source = lv_text_mesage ).
    " append the terminator byte LF to the message frame bevor sending
    CONCATENATE lv_binary_message lv_terminator INTO lv_binary_message IN BYTE MODE.
    " send the composed frame
    ri_result->set_binary( lv_binary_message ).

  ENDMETHOD.
ENDCLASS.
