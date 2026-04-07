CLASS zcl_2886_connections DEFINITION
  PUBLIC
  "FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      get_connections
        IMPORTING i_departure          TYPE /dmo/airport_from_id
        RETURNING VALUE(r_connections) TYPE zcert_connections.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2886_connections IMPLEMENTATION.

  METHOD get_connections.

    DATA: lt_conn   TYPE TABLE OF /dmo/connection,
          lt_direct TYPE TABLE OF /dmo/connection,
          wa_result TYPE zcert_connection.

    SELECT *
      FROM /dmo/connection
      INTO TABLE @lt_conn.

    LOOP AT lt_conn ASSIGNING FIELD-SYMBOL(<fs_direct>)
    WHERE airport_from_id = i_departure.
      CLEAR wa_result.
      wa_result-carrier_id      = <fs_direct>-carrier_id.
      wa_result-airport_from_id = <fs_direct>-airport_from_id.
      wa_result-airport_to_id   = <fs_direct>-airport_to_id.
      wa_result-airport_via_id  = '-'.
      APPEND wa_result TO r_connections.
    ENDLOOP.

    LOOP AT lt_conn ASSIGNING FIELD-SYMBOL(<fs_onward>)
    WHERE carrier_id    = <fs_direct>-carrier_id
    AND airport_from_id = <fs_direct>-airport_to_id
    AND airport_to_id <> i_departure .
      CLEAR wa_result.
      wa_result-carrier_id      = <fs_direct>-carrier_id.
      wa_result-airport_from_id = i_departure.
      wa_result-airport_to_id   = <fs_onward>-airport_to_id.
      wa_result-airport_via_id  = <fs_onward>-airport_to_id.
      APPEND wa_result TO r_connections.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.