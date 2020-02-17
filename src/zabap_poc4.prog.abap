*&---------------------------------------------------------------------*
*& Report zabap_poc4
*&---------------------------------------------------------------------*
*& CHANGE.REQUEST.NO(8000000363)
*& TRANSACTION.ID(1000000090)
*& TRANSPORT.NO(ND5K900196)
*&---------------------------------------------------------------------*
REPORT zabap_poc4.

*&---------------------------------------------------------------------*
*& Data Declaration
*&---------------------------------------------------------------------*
DATA: it_mbew     TYPE TABLE OF mbew.
DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
      wa_fieldcat  TYPE slis_fieldcat_alv.
*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.

*Fetch data from the database
  SELECT * FROM mbew INTO TABLE it_mbew.

*Build field catalog
  wa_fieldcat-fieldname  = 'MATNR'.
  wa_fieldcat-seltext_m  = 'Material Number'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'BWKEY'.
  wa_fieldcat-seltext_m  = 'Valuation Area'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'BKLAS'.
  wa_fieldcat-seltext_m  = 'Base UOM'.
  APPEND wa_fieldcat TO it_fieldcat.

*Pass data and field catalog to ALV function module to display ALV list
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = it_fieldcat
    TABLES
      t_outtab      = it_mbew
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  if sy-subrc <> 0.
    Exit.
  endif.
