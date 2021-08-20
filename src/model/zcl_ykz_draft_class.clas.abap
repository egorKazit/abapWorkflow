class ZCL_YKZ_DRAFT_CLASS definition
  public
  inheriting from /BOBF/CL_LIB_DR
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DRAFT~COPY_DRAFT_TO_ACTIVE_ENTITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YKZ_DRAFT_CLASS IMPLEMENTATION.


  METHOD /bobf/if_frw_draft~copy_draft_to_active_entity.

    DATA lt_header TYPE ztykz_i_requestheadertp.
    DATA lt_changed_fields TYPE HASHED TABLE OF string WITH UNIQUE DEFAULT KEY.

    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key
        it_key                  = it_draft_key
        iv_fill_data            = abap_true
      IMPORTING
        et_data                 = lt_header
        et_failed_key           = DATA(lt_failed_key) ).

    SELECT MAX( requestid ) FROM zykz_i_requestheadertp
      INTO @DATA(lv_counter).

    LOOP AT lt_header REFERENCE INTO DATA(lr_header).
      IF lr_header->requestid IS INITIAL.
        lv_counter = lv_counter + 1.
        lr_header->requestid = lv_counter.
        INSERT zif_ykz_i_requestheadertp_c=>sc_node_attribute-zykz_i_requestheadertp-requestid INTO TABLE lt_changed_fields.
      ENDIF.
      IF lr_header->requeststatus = zif_ykz_constants=>sc_status-header-new.
        lr_header->requeststatus = zif_ykz_constants=>sc_status-header-in_preparation.
        INSERT zif_ykz_i_requestheadertp_c=>sc_node_attribute-zykz_i_requestheadertp-requeststatus INTO TABLE lt_changed_fields.
      ENDIF.

      io_modify->update(
        iv_node           = zif_ykz_i_requestheadertp_c=>sc_node-zykz_i_requestheadertp
        iv_key            = lr_header->key
        iv_root_key       = lr_header->root_key
        is_data           = lr_header
        it_changed_fields = CORRESPONDING #( lt_changed_fields ) ).

    ENDLOOP.

    super->/bobf/if_frw_draft~copy_draft_to_active_entity(
      EXPORTING
        is_ctx              = is_ctx
        it_draft_key        = it_draft_key
        io_read             = io_read
        io_modify           = io_modify
      IMPORTING
        eo_message          = eo_message
        et_key_link         = et_key_link
        et_failed_draft_key = et_failed_draft_key
    ).

  ENDMETHOD.
ENDCLASS.
