class ZCL_ZYKZ_C_LXDEMOWFVALUEHELP definition
  public
  inheriting from CL_SADL_GTK_EXPOSURE_MPC
  final
  create public .

public section.
protected section.

  methods GET_PATHS
    redefinition .
  methods GET_TIMESTAMP
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZYKZ_C_LXDEMOWFVALUEHELP IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~ZYKZ_C_LXDEMOWFVALUEHELP| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20210712192027.
  endmethod.
ENDCLASS.
