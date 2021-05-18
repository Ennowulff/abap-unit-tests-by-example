CLASS ltc_selections DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_autex_selections.
    METHODS:
      setup,
      empty_parameters FOR TESTING RAISING cx_static_check,
      parameter_type_parameters FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltc_selections IMPLEMENTATION.
  METHOD setup.
    cut = NEW zcl_autex_selections( ).
  ENDMETHOD.

  METHOD empty_parameters.
    cl_abap_unit_assert=>assert_initial( cut->get_parameters( ) ).
    DATA param TYPE c.
    cut->get_parameter( i_name = 'PARAM'
                        i_ref_to_parameter = REF #( param ) ).
    cl_abap_unit_assert=>assert_initial( param ).
    DATA range TYPE RANGE OF c.
    cut->get_parameter( i_name = 'RANGE'
                        i_ref_to_parameter = REF #( range ) ).
    cl_abap_unit_assert=>assert_initial( range ).
  ENDMETHOD.

  METHOD parameter_type_parameters.
    DATA selscreen_param1 TYPE c VALUE '1'.
    DATA selscreen_param2 TYPE c VALUE '2'.
    DATA selscreen_param3 TYPE c VALUE '3'.
    cut->add_modify_parameter( VALUE #( name = 'SELSCREEN_PARAM1' type = zif_autex_selections=>c_type-parameter value = REF #( selscreen_param1 ) ) ).
    cut->add_modify_parameter( VALUE #( name = 'SELSCREEN_PARAM2' type = zif_autex_selections=>c_type-parameter value = REF #( selscreen_param1 ) ) ).
    cut->add_modify_parameter( VALUE #( name = 'SELSCREEN_PARAM2' type = zif_autex_selections=>c_type-parameter value = REF #( selscreen_param1 ) ) ).
    cut->add_modify_parameter( VALUE #( name = 'SELSCREEN_PARAM3' type = zif_autex_selections=>c_type-parameter value = REF #( selscreen_param1 ) ) ).
    cl_abap_unit_assert=>assert_equals( act = lines( cut->get_parameters( ) ) exp = 3 ).
    DATA param2 TYPE c.
    cut->get_parameter( i_name = 'SELSCREEN_PARAM2' i_ref_to_parameter = REF #( param2 ) ).
    cl_abap_unit_assert=>assert_equals( act = param2 exp = '1' ).
    DATA param4 TYPE c.
    cut->get_parameter( i_name = 'SELSCREEN_PARAM4' i_ref_to_parameter = REF #( param4 ) ).
    cl_abap_unit_assert=>assert_initial( param4 ).
  ENDMETHOD.
ENDCLASS.
