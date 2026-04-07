CLASS zcl_2886_flight DEFINITION
  PUBLIC
  "FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_carrier_id    TYPE /dmo/carrier_id
          iv_connection_id TYPE /dmo/connection_id
          iv_plane_type    TYPE /dmo/plane_type_id
        RAISING
          zcx_c_abapd_no_connection,

      get_carrier_id
        RETURNING VALUE(rv_carrier_id) TYPE /dmo/carrier_id,
      get_connection_id
        RETURNING VALUE(rv_connection_id) TYPE /dmo/connection_id,
      get_airport_from
        RETURNING VALUE(rv_airport_from) TYPE /dmo/airport_from_id,
      get_airport_to
        RETURNING VALUE(rv_airport_to) TYPE /dmo/airport_to_id.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
    DATA: mv_plane_type     TYPE /dmo/plane_type_id.

  PRIVATE SECTION.
    DATA:
      mv_carrier_id    TYPE /dmo/carrier_id,
      mv_connection_id TYPE /dmo/connection_id,
      mv_airport_from  TYPE /dmo/airport_from_id,
      mv_airport_to    TYPE /dmo/airport_to_id.
ENDCLASS.



CLASS zcl_2886_flight IMPLEMENTATION.
  METHOD constructor.

    mv_carrier_id    = iv_carrier_id.
    mv_connection_id = iv_connection_id.
    mv_plane_type    = iv_plane_type.

    SELECT SINGLE airport_from_id, airport_to_id
      FROM /dmo/connection
      WHERE carrier_id    = @mv_carrier_id
        AND connection_id = @mv_connection_id
        INTO (@mv_airport_from, @mv_airport_to).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.
  ENDMETHOD.

  METHOD get_carrier_id.
    rv_carrier_id = mv_carrier_id.
  ENDMETHOD.

  METHOD get_connection_id.
    rv_connection_id = mv_connection_id.
  ENDMETHOD.

  METHOD get_airport_from.
    rv_airport_from = mv_airport_from.
  ENDMETHOD.

  METHOD get_airport_to.
    rv_airport_to = mv_airport_to.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.

ENDCLASS.