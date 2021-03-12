# Proyecto E-commerce | Clase Análisis y Diseño de Sistemas (IS702) | UNAH marzo 10 2021
Proyecto de Análisis y Diseño de Sistemas (IS-702) Sección 1801 Aplicación para un proveedor de productos electrónicos que opera tanto en un sitio web como una cadena de muchas tiendas físicas. 

@author kenneth.cruz@unah.hn
@version 0.1.0
@date 2021-03-11


# Análisis | Proyecto E-commerce IS-702

## 1. Reglas de negocio
### Proveedor de **productos electrónicos** 

- Tienda     
    - Segmentada por región
- Opera de forma virtual y con establablecimiento física (muchas tiendas a nivel nacional)
- Operaciones de la empresa que incluye el área de logística
- Los gerentes pueden querer ver datos de ventas: 
    - Por período de tiempo
    - Producto
    - Grupo de productos
    - Temporada
        - Navidad 
        - Black Friday
        - Día de las madres
        - Día del padre
        - San Valentín, 
    - Región (por tiendas)
- Productos
    - Agrupados por categoría
        - Tipo de producto 
            - Cámaras y Fotografía 
            - televisor
                - Televisiones QLED
                - TV LED 
                - TV LCD 
            - Teléfono
            - Consola
                - PlayStation 4
                - PlayStation 3
                - Xbox One
                - Xbox 360
                - Nintendo Switch
                - Wii U
                - Wii
                - Nintendo 3DS
                - Nintendo DS
                - PlayStation Vita
                - PSP 
            - Computadora
                - Computadoras de Escritorio
                - Laptops
                - Tablets
            - Monitor
            - Audio
            - Accesorios
                - Cables
                - soportes tv
            - Impresora
                - Impresoras de Etiquetas
                - Impresoras de Fotografías
                - Impresoras de Inyección de Tinta
                - Impresoras Láser
                - Impresoras Matriciales
        - Fabricante 
            - Samsung
            - Apple
            - Xiaomi
            - Huawei
            - Sony
            - Blu
            - Lenovo
            - HP
            - Microsoft
            - Asus
            - Epson
        - Combos de productos en paquetes (una laptop + impresora)
- Clientes
    - Contrato con la empresa
        - Facturan sus compras a un número de cuenta (RTN?)  
            Estos son clientes que tienen empresas y revenden nuestro producto?
        - Faturan mensualmente
    - Poco frecuentes
        - Tarjeta de crédito o debito
            - Pago en linea
                - Se almacena la información de la tarjeta
                    - Número de la tarjeta
                    - Nombre en la tarjeta
                    - Fecha de vencimiento
                    - Código de seguridad
            - Pago en Tienda 
- Ventas 
    - En línea
        - Enviarse a un remitente (el brother que envía el producto por nosotros)
            - Es necesario un seguimiento para responder a las consultas de los clientes
- Inventario 
    -  Cuando es bajo se hace un *pedido* a los fabricantes, esto debe verse reflejado en la base de datos
    - Al llegar la mercancía delos fabricantes 
        - inventario se actualiza
        - Los nuevos *pedidos* se marcan como completados

## 2. Entidades 

- Persona (generalización)
    - Cliente
    - Empleado

- Local (generalización)
    - Proveedor (Fabricante)
    - Tienda 
    - Remitente (delivery)

- Producto
    - Tipo de producto
        - Combo de producto (entidad débil)
        - Interfaz
            - televisor
            - Monitor
        - Computadora
            - Consola
            - Escritorio
            - Portatil
                - Laptop
                - Teléfono
        - Impresora
        - Audio
            - Parlento portatil
            - Tatro en casa
            - Equipo de sonido
        - Accesorios

- Carrito de compra

- Tarjeta de debito

- Inventario

- Pedido

## 3. Entidades y atributos

- Persona(id, dni, primer_nombre, apellido, direccion, telefono, genero, email, fecha_nacimiento)
    - Empleado(id, sueldo, fecha_contratacion)
    - Cliente(id, tipo_cliente)

- Local(id, direccion, telefono)
    - Proveedor(id, nombre_empresa, nombre_encargado)
    - Tienda(id)
    - Remitente(id)

- Producto(id, fabricante, marca,  modelo, descripcion, precio_venta, año_fabricacion, foto)
    - Interfaz(id, tecnologia_panel, diagonal_pantalla, resolucion)
        - Monitor(id, tiempo_respuesta, tasa_refresco)
        - Televisor(id, smart)

    - Computadora(id, procesador, ram, almacenamiento, tipo_almacenamiento)
        - Consola(id, unidad_optica, gpu, accesorio_incluido, tipo_consola)
        - Escritorio(id, formato_case, color_case)
        - Portatil(id, diagonal_pantalla, miliamperes_bateria, sistema_operativo)
            - Laptop_tablet(id, tipo_dispositivo)
            - Celular(id, color, tenología)

    - Impresora(id, tipo_impresora, tamaño_papel, conectividad, velocidad_impresión)

    - Audio(id, potencia, conectividad)
        - Parlante_portatil(id, duracion, resistencia_agua)
        - Teatro_casa (id, puerto)
        - Equipo_sonido(id, formatos_reproducción )

    - Accesorio(id, )
        - Teclado(id, rgb, tipo)
        - Auricular(id)

- Pedido(id, numero_orden, recibo_envio, fecha_envio)



## Referencia

<label><a href="https://www.jetstereo.com/audio">Jetstereo: Audio</label>  

<label><a href="https://www.amazon.com/s?i=electronics-intl-ship&bbn=16225009011&rh=n%3A1266092011%2Cn%3A172659&dc&language=es&qid=1615461740&rnid=1266092011&ref=sr_nr_n_16">Amazon: Tv y video</label>  
<label><a href="https://www.walmart.com/m/electronics/tvs">Walmart: Tv</label>  

<label><a href="https://www.amazon.com/s?i=computers-intl-ship&bbn=16225007011&rh=n%3A16225007011%2Cn%3A1292115011&dc&fs=true&language=es&qid=1615542936&rnid=16225007011&ref=sr_nr_n_12">Amazon: Monitores</label>  
<label><a href="https://www.walmart.com/browse/computers/computer-monitors/3944_3951_1230331">Walmart: Monitores</label>  
<label><a href="https://www.diunsa.hn/es/tecnolog%C3%ADa/computadoras-y-accesorios/impresoras-y-monitores?O=OrderByReleaseDateDESC">Diunsa: Monitores</label>  

<label><a href="https://www.amazon.com/s?i=computers-intl-ship&bbn=16225007011&rh=n%3A16225007011%2Cn%3A13896617011&dc&fs=true&language=es&qid=1615542936&rnid=16225007011&ref=sr_nr_n_6">Amazon: Laptop y Tablet</label>  
<label><a href="https://www.diunsa.hn/es/tecnolog%C3%ADa/computadoras-y-accesorios/computadoras?O=OrderByReleaseDateDESC">Diunsa: Laptop</label>  
<label><a href="https://www.diunsa.hn/es/tecnolog%C3%ADa/computadoras-y-accesorios/tablets?O=OrderByReleaseDateDESC">Diunsa: Tablet</label>  
<label><a href="https://www.walmart.com/m/electronics/computers">Walmart: Laptop</label>  
<label><a href="https://www.walmart.com/m/electronics/tablets">Walmart: Tablet</label>  


<label><a href="https://www.amazon.com/-/es/Samsung-Tel%C3%A9fono-celular-desbloqueado-Smartphone/dp/B08N3BYNDN/ref=sr_1_4?dchild=1&qid=1615462222&rnid=2811119011&s=electronics&sr=1-4&th=1">Amazon: Smartphone</label>  
<label><a href="https://www.walmart.com/m/electronics/cellphones">Walmart: Smartphone</label>  

<label><a href="https://www.amazon.com/s?i=computers-intl-ship&bbn=16225007011&rh=n%3A16225007011%2Cn%3A172635&dc&fs=true&language=es&qid=1615542936&rnid=16225007011&ref=sr_nr_n_11">Amazon: Impresoras</label>  
<label><a href="https://www.walmart.com/m/electronics/computers?_be_shelf_id=69011&cat_id=3944_3951_37807_163957&facet=shelf_id%3A69011">Walmart: Impresoras</label>  

<label><a href="https://www.jetstereo.com/consolas">Jetstereo: Consolas</label>  
<label><a href="https://www.amazon.com/s?k=consola&i=videogames&rh=n%3A6427814011&page=2&language=es&__mk_es_US=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1615474504&ref=sr_pg_2">Amazon: Consolas</label>  
<label><a href="https://www.diunsa.hn/consola-nintendo-switch-5-5---coral/p">Diunsa: Consolas</label>  
<label><a href="https://www.xataka.com/videojuegos/ps5-tiene-precio-fecha-lanzamiento-oficiales-499-euros-399-euros-digital-edition-a-partir-12-noviembre">Xakata: PS5</label>  
<label><a href="https://www.vidaextra.com/xbox-one/xbox-scorpio-vs-ps4-vs-xbox-one-vs-ps4-comparativa-con-las-especificaciones-tecnicas-de-cada-una">Xakata: Xbox Scorpio</label>  




