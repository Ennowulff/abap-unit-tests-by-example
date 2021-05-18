class ZCL_AUTEX_SELECTIONS definition
  public
  final
  create public .

  " https://answers.sap.com/articles/13361225/unit-tests-in-an-sap-customer-environment.html?childToView=13388132#comment-13388132
public section.

  interfaces ZIF_AUTEX_SELECTIONS .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA
      parameters TYPE zif_autex_selections~ty_parameters.

ENDCLASS.



CLASS ZCL_AUTEX_SELECTIONS IMPLEMENTATION.


  METHOD zif_autex_selections~add_modify_parameter.
    FIELD-SYMBOLS <parameter> TYPE zif_autex_selections~ty_parameter.
    IF line_exists( parameters[ name = i_parameter-name ] ).
      ASSIGN parameters[ name = i_parameter-name ] TO <parameter>.
    ELSE.
      INSERT INITIAL LINE INTO TABLE parameters ASSIGNING <parameter>.
    ENDIF.
    MOVE-CORRESPONDING i_parameter TO <parameter>.
  ENDMETHOD.


  METHOD zif_autex_selections~get_parameter.
    IF line_exists( parameters[ name = i_name ] ).
      DATA(parameter) = parameters[ name = i_name ].
      ASSIGN parameter-value->* TO FIELD-SYMBOL(<parameter>).
      ASSIGN i_ref_to_parameter->* TO FIELD-SYMBOL(<report_parameter>).
      <report_parameter> = <parameter>.
    ENDIF.
  ENDMETHOD.


  METHOD zif_autex_selections~get_parameters.
    r_result = parameters.
  ENDMETHOD.
ENDCLASS.
