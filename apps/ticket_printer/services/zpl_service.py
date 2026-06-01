class ZPLGenerator:
    # Layout constants (4x2 inches, 8 dpmm -> 812x406 dots)
    LABEL_WIDTH = 812
    HEADER_Y = 10
    HEADER_HEIGHT = 55
    BODY_Y_START = 75
    SEPARATOR_X = 490
    COL_LEFT_X = 30
    COL_LEFT_WIDTH = 445
    COL_RIGHT_X = 505
    COL_RIGHT_WIDTH = 280
    FOOTER_Y = 315
    FOOTER_HEIGHT = 60

    @staticmethod
    def generate_label(order, volume_num: int, total_volumes: int) -> str:
        """
        Generates the ZPL string for a volume label of a given order.

        Uses a two-column layout (60/40) for a 4x2 inch label.
        """
        # Safe extraction of address attributes
        address = (
            order.customer.address
            if (order.customer and order.customer.address)
            else None
        )

        street = address.street if address else ""
        number = address.number if address else ""
        complement = (address.complement or "").strip() if address else ""
        district = address.district if address else ""
        city = address.city if address else ""
        state = address.state if address else ""
        zip_code = address.zip_code if address else ""

        # Format left column address components
        street_parts = []
        if street:
            street_parts.append(street)
        if number:
            street_parts.append(number)
        street_num = ", ".join(street_parts) if street_parts else ""

        # Format city and state components
        city_state_parts = []
        if city:
            city_state_parts.append(city)
        if state:
            city_state_parts.append(state)
        city_state = (
            " / ".join(city_state_parts).upper() if city_state_parts else ""
        )

        is_rj = city.strip().upper() == "RIO DE JANEIRO"

        # General order and delivery components
        picking = order.picking or ""
        route = (
            order.delivery.route
            if (order.delivery and order.delivery.route)
            else ""
        )
        customer_name = order.customer.name if order.customer else ""
        order_number = order.order_number or ""

        # Construct ZPL layout sections
        header_zpl = ZPLGenerator._build_header(picking, route)
        left_col_zpl = ZPLGenerator._build_left_column(
            customer_name, street_num, complement
        )
        right_col_zpl = ZPLGenerator._build_right_column(
            district, city_state, zip_code, order_number, is_rj
        )
        footer_zpl = ZPLGenerator._build_footer(volume_num, total_volumes)

        # Vertical column separator line at X=490
        vertical_separator = (
            f"^FO{ZPLGenerator.SEPARATOR_X},{ZPLGenerator.BODY_Y_START}"
            "^GB3,220,3^FS"
        )

        zpl = f"""^XA
^CI28

{header_zpl}

{left_col_zpl}

{vertical_separator}

{right_col_zpl}

{footer_zpl}

^XZ"""  # noqa: E501
        return zpl

    @staticmethod
    def _build_header(picking: str, route: str) -> str:
        """Builds header ZPL with picking and route (negative BG)."""
        header_y = ZPLGenerator.HEADER_Y
        header_h = ZPLGenerator.HEADER_HEIGHT
        return f"""^FO20,{header_y}^GB770,{header_h},{header_h}^FS
^A0N,50,40
^FO30,12^FR^FD{picking}^FS
^A0N,40,32
^FO410,18^FR^FB370,1,0,R,0^FD{route}^FS"""

    @staticmethod
    def _build_left_column(name: str, street_num: str, complement: str) -> str:
        """Builds left column ZPL (name, address, complement)."""
        parts = [
            f"^A0N,32,24\n^FO{ZPLGenerator.COL_LEFT_X},75^FB{ZPLGenerator.COL_LEFT_WIDTH},2,0,L,0^FD{name}^FS",
            f"^A0N,28,20\n^FO{ZPLGenerator.COL_LEFT_X},135^FB{ZPLGenerator.COL_LEFT_WIDTH},2,0,L,0^FD{street_num}^FS",
        ]
        if complement:
            parts.append(
                f"^A0N,24,18\n^FO{ZPLGenerator.COL_LEFT_X},185^FB{ZPLGenerator.COL_LEFT_WIDTH},1,0,L,0^FD{complement}^FS"
            )
        return "\n\n".join(parts)

    @staticmethod
    def _build_right_column(
        district: str,
        city_state: str,
        zip_code: str,
        order_number: str,
        is_rj: bool,
    ) -> str:
        """Builds right column ZPL (district, city/state, ZIP, order)."""
        district_bg = "^FO500,75^GB290,40,40^FS\n" if is_rj else ""
        district_fr = "^FR" if is_rj else ""
        district_section = f"""{district_bg}^A0N,34,26
^FO505,80{district_fr}^FB{ZPLGenerator.COL_RIGHT_WIDTH},1,0,L,0^FD{district}^FS"""

        city_state_bg = "^FO500,120^GB290,36,36^FS\n" if not is_rj else ""
        city_state_fr = "^FR" if not is_rj else ""
        city_state_section = (
            f"{city_state_bg}^A0N,28,20\n"
            f"^FO505,125{city_state_fr}^FB"
            f"{ZPLGenerator.COL_RIGHT_WIDTH},1,0,L,0^FD{city_state}^FS"
        )

        return f"""{district_section}

{city_state_section}

^A0N,28,20
^FO505,165^FB{ZPLGenerator.COL_RIGHT_WIDTH},1,0,L,0^FDCEP: {zip_code}^FS

^A0N,26,18
^FO505,195^FB{ZPLGenerator.COL_RIGHT_WIDTH},1,0,L,0^FD{order_number}^FS"""

    @staticmethod
    def _build_footer(volume_num: int, total_volumes: int) -> str:
        """Builds footer ZPL section with volume centered/negative."""
        return f"""^FO20,300^GB770,3,3^FS

^FO20,{ZPLGenerator.FOOTER_Y}^GB770,{ZPLGenerator.FOOTER_HEIGHT},{ZPLGenerator.FOOTER_HEIGHT}^FS
^A0N,55,45
^FO0,320^FR^FB{ZPLGenerator.LABEL_WIDTH},1,0,C^FD{volume_num}/{total_volumes}^FS"""
