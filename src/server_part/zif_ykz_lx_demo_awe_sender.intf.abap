interface ZIF_YKZ_LX_DEMO_AWE_SENDER
  public .


  interfaces IF_APC_WSP_EVENT_HANDLER .
  interfaces IF_APC_WSP_EVENT_HANDLER_BASE .

  class-methods GET_INSTANCE
    returning
      value(RI_RESULT) type ref to ZIF_YKZ_LX_DEMO_AWE_SENDER .
  methods SEND
    importing
      !IV_MESSAGE type STRING
    raising
      CX_APC_ERROR .
endinterface.
