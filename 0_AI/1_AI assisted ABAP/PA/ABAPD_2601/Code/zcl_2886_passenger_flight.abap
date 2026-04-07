CLASS zcl_2886_passenger_flight DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_2886_flight
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_carrier_id    TYPE /dmo/carrier_id
          iv_connection_id TYPE /dmo/connection_id
          iv_plane_type    TYPE /dmo/plane_type_id
        RAISING
          zcx_c_abapd_no_connection.
  PROTECTED SECTION.
  PRIVATE SECTION.
      DATA: mv_seats_max TYPE /dmo/plane_seats_max.
ENDCLASS.



CLASS zcl_2886_passenger_flight IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_carrier_id    = iv_carrier_id
      iv_connection_id = iv_connection_id
      iv_plane_type    = iv_plane_type
    ).

    SELECT SINGLE MaximumSeats
      FROM ZI_CABAPD_PASSENGER
      WHERE PlaneTypeId = @iv_plane_type
      INTO @mv_seats_max.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.
  ENDMETHOD.

ENDCLASS.