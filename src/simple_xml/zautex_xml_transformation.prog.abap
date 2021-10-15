REPORT zautex_xml_transformation.



CLASS ca DEFINITION.
  PUBLIC SECTION.
    METHODS create_response_head
      IMPORTING
        data       TYPE any
      RETURNING
        VALUE(xml) TYPE string.
  PROTECTED SECTION.
    METHODS transform_structure2xml
      IMPORTING
        data       TYPE any
      RETURNING
        VALUE(xml) TYPE string.
    METHODS transform_xml_soap_substr
      IMPORTING
        xml_in         TYPE string
      RETURNING
        VALUE(xml_out) TYPE string.
    METHODS transform_xml_soap_replace
      IMPORTING
        xml_in         TYPE string
      RETURNING
        VALUE(xml_out) TYPE string.
ENDCLASS.

CLASS ca IMPLEMENTATION.
  METHOD create_response_head.

    IF data IS NOT INITIAL.
      xml = transform_structure2xml( data ).
      xml = transform_xml_soap_substr( xml ).
*    xml = transform_xml_soap_replace( xml ).
    ENDIF.

  ENDMETHOD.

  METHOD transform_structure2xml.

    DATA(xml_doc) = NEW cl_xml_document( ).
    xml_doc->set_encoding( 'UTF-16' ).
    IF xml_doc->create_with_data(  dataobject = data ) = 0.
      xml_doc->render_2_string(
      IMPORTING
        retcode = DATA(error_render)
        stream  = xml
        size    = DATA(tabix) ).
    ENDIF.

  ENDMETHOD.

  METHOD transform_xml_soap_replace.
    DATA tag TYPE c LENGTH 10 VALUE `SOAP`.

    xml_out = xml_in.

    "<?xml...?> wird für die SOAP Nachricht entfernt
    REPLACE FIRST OCCURRENCE OF REGEX '<\?xml[^>]*\?>' IN xml_out WITH ''.

    CONCATENATE '/' tag INTO DATA(endtag).

    REPLACE FIRST OCCURRENCE OF '<DATA>'  IN xml_out WITH '<' && tag && '>' && '<HEAD>'.
    REPLACE FIRST OCCURRENCE OF '</DATA>' IN xml_out WITH '</HEAD>' && '<' && endtag && '>'.

  ENDMETHOD.

  METHOD transform_xml_soap_substr.
    DATA tag TYPE c LENGTH 10 VALUE `SOAP`.

    "End-Tag zusammensetzen
    CONCATENATE '/' tag INTO DATA(endtag).

    " XML-Kopf (<?xml...?> wird für die SOAP Nachricht entfernt, bzw. durch SOAP-Envelope später gesetzt
    " <Data>-Knoten entfernen, bzw. durch "mv_tag" und <head> ersetzen.
    " ( <DATA/> tritt nicht auf, da ms_head nicht initial sein kann.)
    xml_out = xml_in.
    xml_out = '<' && tag && '>' && '<HEAD>' && substring_after( val = xml_out sub = '<DATA>' ).
    xml_out = substring_before( val = xml_out sub = '</DATA>' ) && '</HEAD>' && '<' && endtag && '>'.

  ENDMETHOD.

ENDCLASS.

CLASS test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    DATA f_cut TYPE REF TO ca.
    METHODS setup.
    METHODS simple FOR TESTING.
    METHODS empty_field FOR TESTING.
    METHODS empty_structure_int FOR TESTING.
    METHODS empty_structure_char FOR TESTING.
    METHODS int_initial FOR TESTING.
ENDCLASS.

CLASS test IMPLEMENTATION.
  METHOD setup.
    f_cut = NEW #( ).
  ENDMETHOD.

  METHOD simple.
    TYPES: BEGIN OF _simple_structure,
             field1 TYPE c LENGTH 10,
             field2 TYPE i,
           END OF _simple_structure.
    DATA(simple_structure) = VALUE _simple_structure(
       field1 = 'MYTEST' field2 = 122 ).

    cl_abap_unit_assert=>assert_equals(
        act = f_cut->create_response_head( simple_structure )
        exp = `<SOAP><HEAD><FIELD1>MYTEST</FIELD1><FIELD2>122</FIELD2></HEAD></SOAP>` ).

  ENDMETHOD.

  METHOD empty_field.
    TYPES: BEGIN OF _simple_structure,
             field1 TYPE c LENGTH 10,
             field2 TYPE i,
           END OF _simple_structure.
    DATA(simple_structure) = VALUE _simple_structure( field2 = 122 ).

    cl_abap_unit_assert=>assert_equals(
        act = f_cut->create_response_head( simple_structure )
        exp = `<SOAP><HEAD><FIELD2>122</FIELD2></HEAD></SOAP>` ).

  ENDMETHOD.

  METHOD empty_structure_int.
    TYPES: BEGIN OF _simple_structure,
             field1 TYPE c LENGTH 10,
             field2 TYPE i,
           END OF _simple_structure.
    DATA(simple_structure) = VALUE _simple_structure( ).

    cl_abap_unit_assert=>assert_equals(
        act = f_cut->create_response_head( simple_structure )
        exp = `` ).

  ENDMETHOD.

  METHOD int_initial.
    TYPES: BEGIN OF _simple_structure,
             field1 TYPE c LENGTH 10,
             field2 TYPE i,
           END OF _simple_structure.
    DATA(simple_structure) = VALUE _simple_structure( field1 = 'TEST').

    cl_abap_unit_assert=>assert_equals(
        act = f_cut->create_response_head( simple_structure )
        exp = `<SOAP><HEAD><FIELD1>TEST</FIELD1><FIELD2>0</FIELD2></HEAD></SOAP>` ).

  ENDMETHOD.

  METHOD empty_structure_char.
    TYPES: BEGIN OF _simple_structure,
             field1 TYPE c LENGTH 10,
             field2 TYPE c LENGTH 10,
           END OF _simple_structure.
    DATA(simple_structure) = VALUE _simple_structure( ).

    cl_abap_unit_assert=>assert_equals(
        act = f_cut->create_response_head( simple_structure )
        exp = `` ).

  ENDMETHOD.

ENDCLASS.
