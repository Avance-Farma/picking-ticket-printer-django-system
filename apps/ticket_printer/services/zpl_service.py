class ZPLGenerator:
    @staticmethod
    def generate_label(order, volume_num: int, total_volumes: int) -> str:
        """
        Gera a string ZPL para a etiqueta do volume especificado para o pedido.
        """
        # Endereço formatado em duas partes para melhor legibilidade
        addr_main = []
        address = (
            order.customer.address
            if order.customer and order.customer.address
            else None
        )

        if address and address.street:
            addr_main.append(address.street)
        if address and address.number:
            addr_main.append(f"{address.number}")
        if address and address.district:
            addr_main.append(f"- {address.district}")

        addr_sub = []
        city_uf = []
        if address and address.city:
            city_uf.append(address.city)
        if address and address.state:
            city_uf.append(address.state)
        if city_uf:
            addr_sub.append(" / ".join(city_uf))
        if address and address.zip_code:
            addr_sub.append(f"CEP: {address.zip_code}")

        street_num = (
            f"{address.street or ''}, {address.number or ''}"
            if address
            else ""
        )
        district = address.district if address else ""
        city_state_zip = (
            f"{address.city or ''}/ "
            f"{address.state or ''} - {address.zip_code or ''}"
            if address
            else ""
        )

        city = (address.city or "").strip().upper() if address else ""
        is_rj = city == "RIO DE JANEIRO"

        city_state_zip = (
            f"{address.city or ''} / "
            f"{address.state or ''} - {address.zip_code or ''}"
            if address
            else ""
        ).upper()

        if is_rj:
            district_zpl = (
                "^FO20,190^GB770,50,50^FS\n"
                "            ^A0N,40,30\n"
                f"            ^FO30,195^FR^FB750,1,0,L,0^FD{district}^FS"
            )
            city_zpl = (
                "^A0N,30,25\n"
                f"            ^FO30,250^FB750,1,0,L,0^FD{city_state_zip}^FS"
            )
        else:
            district_zpl = (
                "^A0N,40,30\n"
                f"            ^FO30,195^FB750,1,0,L,0^FD{district}^FS"
            )
            city_zpl = (
                "^FO20,240^GB770,45,45^FS\n"
                "            ^A0N,30,25\n"
                f"            ^FO30,248^FR^FB750,1,0,L,0^FD{city_state_zip}^FS"
            )

        zpl = f"""^XA
            ^CI28

            ^FO20,10^GB770,55,55^FS
            ^A0N,45,35
            ^FO30,15^FR^FD{order.picking}^FS
            ^A0N,35,30
            ^FO450,20^FR^FB330,1,0,R,0^FD{order.delivery.route if order.delivery else ""}^FS

            ^A0N,30,25
            ^FO30,75^FB750,2,0,L,0^FD{order.customer.name if order.customer else ""}^FS

            ^A0N,25,20
            ^FO30,135^FB750,2,0,L,0^FD{street_num}^FS

            {district_zpl}

            {city_zpl}

            ^FO20,300^GB770,3,3^FS

            ^FO20,315^GB770,60,60^FS
            ^A0N,45,40
            ^FO0,323^FR^FB812,1,0,C^FD{volume_num}/{total_volumes}^FS

        ^XZ"""  # noqa: E501
        return zpl
