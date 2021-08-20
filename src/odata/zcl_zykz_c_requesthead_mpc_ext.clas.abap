CLASS zcl_zykz_c_requesthead_mpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zykz_c_requesthead_mpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS define REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zykz_c_requesthead_mpc_ext IMPLEMENTATION.

  METHOD define.
    super->define( ).
*    DATA lo_annotation TYPE REF TO /iwbep/if_mgw_odata_annotation.
*    DATA  lo_property TYPE REF TO /iwbep/if_mgw_odata_property.
*    DATA  lo_entity_set TYPE REF TO /iwbep/if_mgw_odata_entity_set.
*    lo_entity_set = model->get_entity_set( 'ZYKZ_C_RequestHeaderTP' ).
*    lo_annotation = lo_entity_set->create_annotation( 'sap' ).
*    lo_annotation->add( iv_key = 'semantics' iv_value = 'fixed-values').
*    DATA(lo_entitytype) = model->get_entity_type( 'ZYKZ_C_RequestHeaderTPType' ).
*    lo_entitytype->set_is_value_list( abap_true ).
*    DATA(lo_txt_property) = model->get_entity_type( 'ZYKZ_C_RequestHeaderTPType' )->get_property( 'RequestStatus' ).
*    lo_txt_property->set_value_list( /iwbep/if_mgw_odata_property=>gcs_value_list_type_property-fixed_values ).
*    DATA(lo_text_anno) = lo_txt_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' ).
*    lo_text_anno->add( iv_key = 'text' iv_value = 'to_RequestStatusVH/RequestStatus').
*    lo_txt_property = model->get_entity_type( 'ZYKZ_C_RequestStatusVHType' )->get_property( 'RequestStatus' ).
*    lo_txt_property->set_value_list( /iwbep/if_mgw_odata_property=>gcs_value_list_type_property-fixed_values ).
*    lo_text_anno = lo_txt_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' ).
*    lo_text_anno->add( iv_key = 'text' iv_value = 'status_text').
  ENDMETHOD.

ENDCLASS.
