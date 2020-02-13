*&---------------------------------------------------------------------*
*& Report zabap_poc1
*&---------------------------------------------------------------------*
*& CHANGE.REQUEST.NO(8000000338)
*& TRANSACTION.ID(1000000074)
*& TRANSPORT.NO(ND5K900162)
*&---------------------------------------------------------------------*

REPORT zabap_poc1.

*&---------------------------------------------------------------------*
*& Data Declaration
*&---------------------------------------------------------------------*
DATA: it_mara     TYPE TABLE OF mara.
DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
      wa_fieldcat  TYPE slis_fieldcat_alv.
*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.

*Fetch data from the database
  SELECT * FROM mara INTO TABLE it_mara
           where MATNR like 'AUT%'.

*Build field catalog
  wa_fieldcat-fieldname  = 'MATNR'.
  wa_fieldcat-seltext_m  = 'Material Number'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'MTART'.
  wa_fieldcat-seltext_m  = 'Material type'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'ERSDA'.
  wa_fieldcat-seltext_m  = 'Created On'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'MEINS'.
  wa_fieldcat-seltext_m  = 'Base UOM'.
  APPEND wa_fieldcat TO it_fieldcat.

*Pass data and field catalog to ALV function module to display ALV list
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat   = it_fieldcat
    TABLES
      t_outtab      = it_mara
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  if sy-subrc <> 0.
    Exit.
  endif.
