CLASS lcl_combinations DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_autex_combinations.  "class under test
    METHODS setup.

    METHODS: check_combination_x_x FOR TESTING.
    METHODS: check_combination_x_o FOR TESTING.
    METHODS: check_combination_x_n FOR TESTING.
    METHODS: check_combination_x__ FOR TESTING.

    METHODS: check_combination_o_x FOR TESTING.
    METHODS: check_combination_o_o FOR TESTING.
    METHODS: check_combination_o_n FOR TESTING.
    METHODS: check_combination_o__ FOR TESTING.

    METHODS: check_combination_n_x FOR TESTING.
    METHODS: check_combination_n_o FOR TESTING.
    METHODS: check_combination_n_n FOR TESTING.
    METHODS: check_combination_n__ FOR TESTING.


ENDCLASS.       "lcl_Combinations


CLASS lcl_combinations IMPLEMENTATION.

  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.

  METHOD check_combination_x_x.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'X' option_specific  = 'X' )
      exp   = 'X'    ).
  ENDMETHOD.

  METHOD check_combination_x_o.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'X' option_specific  = 'O' )
      exp   = 'O'    ).
  ENDMETHOD.

  METHOD check_combination_x_n.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'X' option_specific  = 'N' )
      exp   = 'N'    ).
  ENDMETHOD.

  METHOD check_combination_x__.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'X' option_specific  = ' ' )
      exp   = 'X'    ).
  ENDMETHOD.

  METHOD check_combination_o_x.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'O' option_specific  = 'X' )
      exp   = 'O'    ).
  ENDMETHOD.

  METHOD check_combination_o_o.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'O' option_specific  = 'O' )
      exp   = 'O'    ).
  ENDMETHOD.

  METHOD check_combination_o_n.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'O' option_specific  = 'N' )
      exp   = 'N'    ).
  ENDMETHOD.

  METHOD check_combination_o__.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'O' option_specific  = ' ' )
      exp   = 'O'    ).
  ENDMETHOD.

  METHOD check_combination_n_x.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'N' option_specific  = 'X' )
      exp   = 'N'    ).
  ENDMETHOD.

  METHOD check_combination_n_o.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'N' option_specific  = 'O' )
      exp   = 'N'    ).
  ENDMETHOD.

  METHOD check_combination_n_n.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'N' option_specific  = 'N' )
      exp   = 'N'    ).
  ENDMETHOD.

  METHOD check_combination_n__.
    cl_abap_unit_assert=>assert_equals(
      act   = f_cut->check_combination( option_general = 'N' option_specific  = ' ' )
      exp   = 'N'    ).
  ENDMETHOD.

ENDCLASS.
