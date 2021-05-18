INTERFACE zif_autex_selections
  PUBLIC .
  TYPES ty_parameter_type TYPE flag.
  TYPES:
    BEGIN OF ty_parameter,
      name  TYPE string,
      type  TYPE ty_parameter_type,
      value TYPE REF TO data,
    END OF ty_parameter.
  TYPES ty_parameters TYPE STANDARD TABLE OF ty_parameter WITH NON-UNIQUE KEY name.
  CONSTANTS:
    BEGIN OF c_type,
      parameter     TYPE ty_parameter_type VALUE 'P',
      select_option TYPE ty_parameter_type VALUE 'S',
    END OF c_type.
  METHODS:
    add_modify_parameter
      IMPORTING
        i_parameter TYPE ty_parameter.
  METHODS
    get_parameters
      RETURNING
        VALUE(r_result) TYPE ty_parameters.
  METHODS get_parameter
    IMPORTING
      i_name             TYPE csequence
      i_ref_to_parameter TYPE REF TO data.
ENDINTERFACE.
