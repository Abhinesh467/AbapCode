*&---------------------------------------------------------------------*
*& Report zabap_poc9
*&---------------------------------------------------------------------*
*& CHANGE.REQUEST.NO(8000000392)
*& TRANSACTION.ID(1000000108)
*& TRANSPORT.NO(ND5K900245)
*&---------------------------------------------------------------------*

REPORT zabap_poc9.

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
  wa_fieldcat-outputlen   = '40'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'MTART'.
  wa_fieldcat-seltext_m  = 'Material type'.
    wa_fieldcat-outputlen   = '15'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'ERSDA'.
  wa_fieldcat-seltext_m  = 'Created On'.
    wa_fieldcat-outputlen   = '15'.
  APPEND wa_fieldcat TO it_fieldcat.

  wa_fieldcat-fieldname  = 'MEINS'.
  wa_fieldcat-seltext_m  = 'Base UOM'.
    wa_fieldcat-outputlen   = '10'.
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
