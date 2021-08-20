interface ZIF_YKZ_LX_DEMO_AWE_HANDLER
  public .


  class-methods GET_INSTANCE
    importing
      !II_MESSAGE type ref to IF_APC_WSP_MESSAGE
      !II_MESSAGE_MANAGER type ref to IF_APC_WSP_MESSAGE_MANAGER
    returning
      value(RI_RESULT) type ref to ZIF_YKZ_LX_DEMO_AWE_HANDLER .
  methods HANDLE_MESSAGE
    raising
      CX_APC_ERROR .
  methods PREPARE_RESPONSE
    importing
      !IV_RESPONSE_CODE type I optional
    returning
      value(RI_RESULT) type ref to IF_APC_WSP_MESSAGE
    raising
      CX_APC_ERROR .
endinterface.
