*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 12.07.2021 at 22:15:08
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZYKZ_C_WF_DM_USR................................*
TABLES: ZYKZ_C_WF_DM_USR, *ZYKZ_C_WF_DM_USR. "view work areas
CONTROLS: TCTRL_ZYKZ_C_WF_DM_USR
TYPE TABLEVIEW USING SCREEN '0100'.
DATA: BEGIN OF STATUS_ZYKZ_C_WF_DM_USR. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZYKZ_C_WF_DM_USR.
* Table for entries selected to show on screen
DATA: BEGIN OF ZYKZ_C_WF_DM_USR_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZYKZ_C_WF_DM_USR.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZYKZ_C_WF_DM_USR_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZYKZ_C_WF_DM_USR_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZYKZ_C_WF_DM_USR.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZYKZ_C_WF_DM_USR_TOTAL.

*.........table declarations:.................................*
TABLES: ZYKZ_WF_DEMO_USR               .
