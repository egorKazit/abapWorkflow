FUNCTION zykz_lx_demo_send_notificaion.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_PARAMETERS) TYPE  CHAR255
*"----------------------------------------------------------------------


  TRY.
      zcl_ykz_lx_demo_awe_sender=>zif_ykz_lx_demo_awe_sender~get_instance(
        )->send( CONV #( i_parameters ) ).
    CATCH cx_apc_error INTO DATA(lo_error).

  ENDTRY.


ENDFUNCTION.
