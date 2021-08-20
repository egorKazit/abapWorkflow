INTERFACE zif_ykz_constants
  PUBLIC .
  CONSTANTS: BEGIN OF sc_status,
               BEGIN OF header,
                 new            TYPE zykz_lx_de_status VALUE '0',
                 in_preparation TYPE zykz_lx_de_status VALUE '1',
                 in_approval    TYPE zykz_lx_de_status VALUE '2',
                 part_approved  TYPE zykz_lx_de_status VALUE '3',
                 approved       TYPE zykz_lx_de_status VALUE '4',
                 rejected       TYPE zykz_lx_de_status VALUE '5',
                 completed      TYPE zykz_lx_de_status VALUE '6',
               END OF header,
             END OF sc_status.
ENDINTERFACE.
