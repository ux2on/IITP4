*&---------------------------------------------------------------------*
*& Include          ZR00_0003CLS
*&---------------------------------------------------------------------*
CLASS LCL_EVENT_RECEIVER DEFINITION.
    PUBLIC SECTION.
  
      METHODS : HANDLE_DOUBLE_CLICK
                    FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
        IMPORTING E_ROW
                    E_COLUMN
                    SENDER.
  
      METHODS : HANDLE_HOTSPOT_CLICK
                    FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
        IMPORTING E_ROW_ID
                    E_COLUMN_ID
                    SENDER.
  
      METHODS : HANDLE_TOOLBAR
                    FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
        IMPORTING E_OBJECT
                    SENDER.
  
      METHODS : HANDLE_USER_COMMAND
                    FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
        IMPORTING E_UCOMM
                    SENDER.
  
ENDCLASS.
  


CLASS LCL_EVENT_RECEIVER IMPLEMENTATION.
  
    METHOD HANDLE_DOUBLE_CLICK.
  
      PERFORM HANDLE_DOUBLE_CLICK USING E_ROW
                                        E_COLUMN
                                        SENDER. 
    ENDMETHOD.
  
    METHOD HANDLE_HOTSPOT_CLICK.
      PERFORM HANDLE_HOTSPOT_CLICK USING E_ROW_ID
                                         E_COLUMN_ID
                                         SENDER.
    ENDMETHOD.
  
    METHOD HANDLE_TOOLBAR.
      PERFORM HANDLE_TOOLBAR USING E_OBJECT
                                   SENDER.
    ENDMETHOD.
  
    METHOD HANDLE_USER_COMMAND.
      PERFORM HANDLE_USER_COMMAND USING E_UCOMM
                                        SENDER.
    ENDMETHOD.
  
ENDCLASS.
  
DATA : GO_EVENT_RECEIVER TYPE REF TO LCL_EVENT_RECEIVER.