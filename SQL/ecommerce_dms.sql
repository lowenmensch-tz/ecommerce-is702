/*
    @author kenneth.cruz@unah.hn
    @version 0.1.0
    @date 15/03/2021
*/


INSERT INTO  Manufacturer(tex_manufacturer, tex_brand) VALUES 
    ("Japan Victor Company", "JVC"),
    ("Samsung", "Samsung"),
    ("LG Corporation", "LG"),
    ("Roku Inc", "Roku"),
    ("Google, LLC", "Google"),
    ("Dell computers & technology solutions", "Dell"), 
    ("Motorola Mobility", "Motorola") 
    
;

INSERT INTO Product(id_manufacturer_fk, tex_model, tex_description, tim_year_launch) VALUES 
    (1, "70W RMS", "Minicomponente", 2019),
    (2, "MX-T70", "Sonido bidireccional | Modo Karaoke | Potenciador de bajo", 2019),
    (2, "MX-T50", "Sistema de sonido Potenciador de bajos", 2020),
    (2, "MX-T40", "Destaca el ritmo de la fiesta | Sonido Bidireccional | Luces LED para fiestas", 2020),
    (3, "SL4", "Subwoofer Inalambrico | Fidelidad de sonido | Sonido envolvente", 2020),
    (3, "XBOOM CL88", "App DJ | Karaoke Star | Fidelidad de sonido | Opción de Karaoke | Conectividad inalámbrica a LG Smart TV", 2020),
    (3, "XBOOM OL45", "TV Sound Sync | Fidelidad de sonido | Opción de Karaoke | Conectividad inalámbrica a LG Smart TV", 2020),
    (3, "XBOOM RM2", "Baja distorsión | Control de eco, entrada 2 mics | Instalación en trípode | Manija", 2020),
    (3, "XBOOM RM1", "Baja distorsión | Control de eco | entrada 2 mics", 2020),
    (3, "XBOOM CM4360", "Karaoke Star | Auto DJ |  Sincronización de sonido con TV", 2021),
    (2, "UHD 4K SmarTV", "Pantalla Crystal Display | Procesador Crystal 4K |  Transmisión digital ISDB-T/DVB-T/ATSC | Bluetooth Sí (BT4.2)", 2021),
    (3, "UHD 4K SmarTV", "Panel de Hogar | Modo Cineasta | Alerta HGiG y Deportes | Diseño tradicional | TruMotion: 60Hz (TM120/TM100) | Procesador: Quad Core Processor 4K | Realzamiento de Imagen: Image Enhancing | HDR: Active HDR | HDR10 Pro Sí/Sí/Sí(4K/2K) | FILMMAKER MODE | 'AUDIO | Parlante (Salida Audio) 20W (10W per Channel) | Canal 2.0ch | Salida de audio simultanea; Si | Sound / Pro Inteligente: AI Sound | Modo Envolvente: Ultra Surround | Compatibilidad para Bluetooth Envolvente: Sí | FUNCIÓN INTELIGENTE(IA) | ThinQ: Si | Screen Share: Si | Wifi: Si | Bluetooth: Si", 2021),
    (1, "", "ISDBT | Diseñado para ofrecer la mejor calidad de imagen y sonido, este televisor tiene Air Mouse que asegura búsqueda más fácil, y la tecnología inteligente para acceder a contenidos en línea a través de sus aplicaciones favoritas. Disfrutar de la alta calidad de imagen y una gran cantidad.", 2021),
    (3, "UHD 4K/NANOCEL/SMART", "NanoCell TV | Colores Puros en 4K Real | Procesador Quad Core 4K | ThinQ™ AI | Experiencia de cine | Entretenimiento sin limitesNano Color / Nano PrecisiónLocal DimmingPanel de HogarModo CineastaAlerta HGiG y Deportes" ,2021), 
    (1, "", "Eleva tu experiencia visual con la hermosa UHD 4K, cuatro veces la resolución que una pantalla Full HD 1080p. High Dynamic Range te permite experimentar la película como el director pensado con colores vivos sin saturar.Accede fácilmente a un gran número de canales y aplicaciones que ofrecen programas de televisión, películas, música y mucho más. Busca, selecciona y ve tu programa favorito con JVC Smart TV. Amplia tecnología de color Gamut puede producir más de mil millones de diferentes tonos de color cautivador. Compatible con cable/satélite, antena y transmisión", 2021), -- 15
    (1, "LT-50KB507", "Netflix, Youtube, Amazon Prime Video y Browser.  |  Audio: Dolby Audio |  Crystal Color Technology – Dolby Vision. - - Diseño: Slim Design – Bezel  |  Color: Black. Built-in WiFi.  |  Accesorios: Remote control One-click Netflix and YouTube.  |  Access to Google Assistant Voice search", 2021), -- 16
    (1, "", "Eleva tu experiencia visual con la hermosa UHD 4K, cuatro veces la resolución que una pantalla Full HD 1080p.High Dynamic Range te permite experimentar la película como el director pensado con colores vivos sin saturar. Accede fácilmente a un gran número de canales y aplicaciones que ofrecen programas de televisión, películas, música y mucho más. Busca, selecciona y ve tu programa favorito con JVC Smart TV. Amplia tecnología de color Gamut puede producir más de mil millones de diferentes tonos de color cautivador. Compatible con cable/satélite, antena y transmisión.", 2021), -- 17
    (1, "", "Nueva JVC Smart TV de 65 pulgadas con Tecnología Android TV, 8GB de Memoria interna, JVC Smart TV con procesador Quad Core, 8GB de almacenamiento y 1 GB de RAM. Cuenta con sistema operativo Android TV 4.4 para acceder a contenidos en línea a través de tus aplicaciones. La Serie JVC de 65 LED Full HD es la mejor en su clase desempeñando una destacable performance en la calidad de imagen y sonido. Cautivante: es el resultado de un marco ultra delgado que le da todo el protagonismo a la performance de esta pantalla única", 2021), -- 18
    (2, "", "4K DVBT", 2021), -- 19
    (2, "", "DVBT", 2021), -- 20
    (4, "ROKU EXPRESS", "Roku Express Purple; al ser compacto y potente, Roku Express sirve para que transmitas de forma fácil tu contenido favorito. Podrás disfrutar en streaming HD desde películas y series en Netflix y Prime Video hasta otras alternativas totalmente gratis como Deezer y Red Bull TV. Con Roku Express, podrás disfrutas de la TV más comentada en canales gratuitos y de paga. Sin cuota mensual por el equipo ni contratos. La búsqueda objetiva facilita encontrar entretenimiento gratis o al menor precio. Compatibilidad - TV HD Hasta 1080p (1920 x 1080) con ampliación desde 720p Roku Express Purple; Al ser compacto y potente, Roku Express sirve para que transmitas de forma fácil tu contenido favorito. Podrás disfrutar en streaming HD desde películas y series en Netflix y Prime Video hasta otras alternativas totalmente gratis como Deezer y Red Bull TV. Con Roku Express, podrás disfrutas de la TV más comentada en canales gratuitos y de paga. Sin cuota mensual por el equipo ni contratos. La búsqueda objetiva facilita encontrar entretenimiento gratis o al menor precio.' |  'Sistema Operativo - .' |  'Conexiones de Salida - 507' |  'Conectividad - 502' |  'Compatibilidad - TV HD Hasta 1080p (1920 x 1080) con ampliación desde 720p", 2021), -- 21
    (4, "ROKU PREMIERE UHD  4K STREAMING", "Transmite HD, 4K, HDR |     Fácil de usar y con una configuración sencilla |     Incluye Cable HDMI® de de ultra alta velocidad |  Disfruta de TV gratis, noticias en vivo, deportes, música, películas y más |     Control remoto sencillo", 2021), -- 22
    (4, "chromecast 3ra Generación", "2.4GHZ+5 GHZ | - Convierte cualquier televisor en Smart TV | - Aplicaciones: Netflix, YouTube, Spotify, HBO Go, Google Play | - Controla desde tu celular, tablet o laptop | - Funciona con Android, iOS y Chrome | - Nueva tecnología wifi de doble banda 2.4 y el apoyo de 5ghz | - Alta calidad de video y audio con menos buffering | - Desempeño mejorado para juegos | - Opción de Streaming con comando de voz usando el app en smartphone o Google Home Mini | Todos juntos ahora: Mira películas, espectáculos, TV en directo, YouTube y fotos en el televisor desde todos los dispositivos de tu familia. | Transmite desde tu teléfono a tu televisor. Así es. Enchufa Chromecast en el puerto HDMI de tu televisor para alimentar y transmitir tu entretenimiento favorito directamente desde tu teléfono con solo un toque. Mira shows, escucha listas de reproducción y mucho más. | Funciona con las aplicaciones de reproducción en línea que conoces y que te encantan. Disfruta de programas de televisión, películas, vídeos, canciones, juegos, deportes y mucho más desde más de 2000 aplicaciones como Netflix, YouTube, YouTube TV y HBO NOW. | Comienza a transmitir música con solo tu voz. Sólo tienes que decir lo que quieres ver desde aplicaciones compatibles y controlar tu TV con manos libres, con Chromecast y Google Home trabajando juntos sin problemas. | Actualiza tu televisor por menos. Amplía tu entretenimiento en casa sin comprar un nuevo televisor. Sistemas operativos compatibles: Android 4.2 y superior, iOS 9.1 y superior a Mac OS X 10.9 y superior, Windows 7 y superior.", 2021), -- 23
    (6, "", "Laptop DELL  1 Conector combinado de salida de audífonos/entrada de micrófono, 1 RJ-15, Micro SD Card", 2020), -- 24
    (6, "Gaming G3", "Pantalla de 15.6'' FHD  | 1 Conector combinado de salida de audífonos/entrada de micrófono, 1 RJ-15, Micro SD Card |  Peso de 2.53Kg (5.58Lb)", 2018), -- 25
    (6, "Athlon Silver", "Laptop escolar", 2021), -- 26
    (6, "Latitude", "1 Conector combinado de salida de audífonos/entrada de micrófono, 1 RJ-15, Micro SD Card |  Peso de 1.91Kg (4.21Lb)", 2020), -- 27
    (6, "Latitude 3180", "Enriquezca la educación. Incentive a los estudiantes:Una laptop de 11.6 pulgadas que ofrece una solución de aprendizaje rentable, diseñada con la mejor durabilidad en su clase para soportar cada día escolar", 2021), -- 28
    (2, "", "Perfil increíblemente fino con un diseño moderno y elegante |Experiencia de juego fluida e impecable con ADM FreeSync | Comodidad de visualización optimizada", 2018), -- 29
    (7, "Moto One Fusion", "El Motorola One Fusion es un smartphone Android con una pantalla HD+ de 6.5 pulgadas. En su interior encontramos un procesador Qualcomm Snapdragon 710 acompañado de 4GB de memoria RAM y 64GB o 128GB de espacio de almacenamiento expandible. La cámara posterior del Motorola One Fusion es cuádruple, con un lente principal de 48 MP y lentes secundarios de 8 MP, 5 MP y 2 MP y su cámara frontal para selfies es de 8 megapixels. Completando las características del Motorola One Fusion tenemos una batería de 5000 mAh, lector de huellas en su posterior, y corre Android 10.", 2020), -- 30
    (7, "G8 Power Lite", "El Motorola Moto G8 Power Lite es una variante del Moto G8 Power con una pantalla HD+ de 6.5 pulgadas y potenciado por un procesador Mediatek Helio P35 acompañado de 4GB de memoria RAM y 64GB de espacio de almacenamiento interno. Con una cámara trasera triple de 16 MP + 2 MP + 2 MP, el Moto G8 Power Lite cuenta con una cámara para selfies de 8 megapixels, batería de 5000 mAh, lector de huellas y corre Android 9.0 Pie.", 2020), -- 31
    (7, "E7 Plus", "El Motorola Moto E7 Plus pasa a integrar la serie Moto E de séptima generación con una pantalla HD+ de 6.5 pulgadas. Por dentro, encontramos un procesador Snapdragon 460 con 4GB de memoria RAM y 64GB de almacenamiento interno expandible.", 2020), -- 32
    (7, "E7 Plus", "El Motorola Moto E7 Plus pasa a integrar la serie Moto E de séptima generación con una pantalla HD+ de 6.5 pulgadas. Por dentro, encontramos un procesador Snapdragon 460 con 4GB de memoria RAM y 64GB de almacenamiento interno expandible.", 2020), -- 33
    (7, "Moto E6s", "El Motorola Moto E6s es una variante del Moto E6 con una pantalla HD+ de 6.1 pulgadas y potenciado por un procesador Mediatek Helio P22. El Moto E6s cuenta con 2GB de memoria RAM y 32GB de espacio de almacenamiento interno expandible, y sus cámaras son de 13 MP + 2 MP en su posterior y 5 megapixels al frente para selfies. El Moto E6s completa sus características con una batería de 3000 mAh, lector de huellas y corre Android 9.0 Pie.", 2020) 
;

INSERT INTO Operative_system(tex_name) VALUES
    ("No disponible"),
    ("Tizen"),
    ("webOS Smart TV"),
    ("Windows"),
    ("Android"),    -- 5
    ("ChromeOs"),
    ("Android TV")
;

INSERT INTO Port(id_product_fk, sma_usb) VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1)
;

INSERT INTO Port(id_product_fk, sma_usb, sma_hdmi) VALUES 
    (11, 1, 1),
    (12, 2, 3),
    (13, 1, 1),
    (15, 2, 3),
    (16, 3, 4),
    (18, 3, 2),
    (19, 1, 2),
    (20, 1, 2),
    (24, 4, 1),
    (28, 2, 1)
;

INSERT INTO Port(id_product_fk, sma_usb, sma_hdmi, sma_typec) VALUES 
    (25, 4, 1, 1),
    (27, 4, 1, 1)
;


--
--  Audio(Equipos de sonido)
--

INSERT INTO Audio(id_product_fk, sma_power, tex_conectivity) VALUES 
    (1, 70, "Bluetooth"),
    (2, 1500, "Bluetooth"),
    (3, 500, "Bluetooth"),
    (4, 300, "Bluetooth"),
    (5, 300, "Bluetooth"),
    (6, 2900, "Bluetooth"),
    (7, 220, "Bluetooth"),
    (8, 80, "Bluetooth"),
    (9, 25, "Bluetooth"),
    (10, 230, "Bluetooth")
;

INSERT INTO Audio_system(id_audio_fk, tex_format_reproduction) VALUES
    (1, "Entrada óptica | USB | Radio FM | Entrada para guitarra"),
    (2, "USB | Radio FM | Entrada para guitarra"),
    (3, "USB | Radio FM"),
    (4, "USB | Radio FM"),
    (6, "USB"),
    (7, "USB"),
    (8, "USB | Tarjeta SD"),
    (9, "USB | Tarjeta SD"),
    (10, "USB | Radio FM")
;

INSERT INTO Home_theater(id_audio_fk, tex_port) VALUES
    (5, "USB")
;

INSERT INTO Portable_speaker(id_audio_fk, tim_battery, bit_water_resistant) VALUES 
    (9, "14:00:00", 0)
;


--
--  Tv y Monitores
--

INSERT INTO Interface(id_product_fk, cod_panel_technology, dec_diagonal, cod_resolution) VALUES 
    (11, 3, 50, 5),
    (12, 3, 70, 5),
    (13, 3, 42, 3),
    (14, 3, 65, 5),
    (15, 3, 55, 5),
    (16, 3, 50, 5),
    (17, 3, 58, 5),
    (18, 3, 65, 5),
    (19, 3, 55, 5), -- 9
    (20, 3, 32, 2),
    (29, 3, 32, 3)
;

-- INSERT INTO Monitor(id_interface_fk, dec_response_time, sma_refresh_rate) VALUES
INSERT INTO Monitor(id_interface_fk) VALUES
    (11)
;

INSERT INTO Tv(id_interface_fk, id_operative_sistem_fk, bit_smart) VALUES
    (1, 1, 1),
    (2, 3, 1),
    (3, 2, 1),
    (4, 1, 1),
    (5, 1, 1),
    (6, 3, 1),
    (7, 1, 1),
    (8, 7, 1),
    (9, 2, 1),
    (10, 2, 1)
;

--
--  Accesorios
-- 

INSERT INTO Accessory(id_product_fk, tex_type) VALUES
    (21, "ADAPTADOR STREAMING"),
    (22, "ADAPTADOR STREAMING"),
    (23, "ADAPTADOR STREAMING")
;

--
--  Computadoras
--

INSERT INTO Computer(id_product_fk, tex_processor, sma_ram, sma_storage, cod_storage_device) VALUES
    (24, "Core i3 10ma Generación", 4, 1024, 1),
    (25, "Core i5 -10300H", 8, 256, 2),
    (26, "AMD Athlon Silver 3050U", 8, 256, 2),
    (27, "Core i5 -10210U", 8, 1024, 1),
    (28, "Intel Celeron", 4, 128, 2),
    (30, "Snapdragon 710 2.2GHz", 4, 64, 5), -- 6
    (31, "Mediatek Helio P35 2.3Ghz", 4, 64, 5), 
    (32, "Qualcomm SM4250 Snapdragon 460 octa-core 1.8GHz", 4, 64, 5),  -- 8
    (33, "Qualcomm SM4250 Snapdragon 460 octa-core 1.8GHz", 4, 64, 5),
    (34, "Mediatek Helio P22 2Ghz", 2, 32, 5) -- 10
;

-- INSERT INTO Portable(id_computer_fk, id_operative_sistem_fk, dec_diagonal, tex_version_os, sma_battery) VALUES
INSERT INTO Portable(id_computer_fk, id_operative_sistem_fk, dec_diagonal, tex_version_os) VALUES
    (1, 4, 15.6, "10 Home"),
    (2, 4, 15.6, "10 Home"),
    (3, 4, 15.6, "10 Home"),
    (4, 4, 15.6, "10 Pro"),
    (5, 4, 11.6, "10 Home")
;

INSERT INTO Portable(id_computer_fk, id_operative_sistem_fk, dec_diagonal, tex_version_os) VALUES
    (6, 5, 6.5, "10"),
    (7, 5, 6.5, "9"),
    (8, 5, 6.5, "10"),
    (9, 5, 6.5, "10"),
    (10, 5, 6.1, "9")
;


INSERT INTO Laptop(id_portable_fk, cod_type) VALUES
    (1 ,4),
    (3 ,4),
    (4 ,4),
    (5 ,4)
;

-- INSERT INTO Laptop(id_portable_fk, tex_graphic, cod_type, tim_battery) VALUES
INSERT INTO Laptop(id_portable_fk, tex_graphic, cod_type) VALUES
    (2, "Graficas NVIDIA GTX 1650 ", 2)
;


INSERT INTO Smartphone(id_portable_fk, tex_color, sma_front_camera, sma_rear_camera, cod_connector, sma_battery) VALUES
    (6, "Negro", 8, 48, 2, 5000),
    (7, "Azul", 2, 16, 1, 5000),
    (8, "Naranja", 8, 48, 1, 5000),
    (9, "Azul", 8, 48, 1, 5000),
    (10, "Rosado", 5, 13, 1, 3000)
;

--
--  Inventario
--
INSERT INTO Inventory(id_product_fk, med_quantity, dec_sale_price, dec_purchase_price) VALUES 
    (1, 249, 20137.530000000002, 15141),
    (2, 186, 8130.290000000001, 6113),
    (3, 211, 15227.17, 11449),
    (4, 66, 7549.080000000001, 5676),
    (5, 102, 14378.630000000001, 10811),
    (6, 34, 8911.0, 6700),
    (7, 345, 23289.63, 17511),
    (8, 340, 9533.44, 7168),
    (9, 449, 15725.92, 11824),
    (10, 74, 6896.05, 5185),
    (11, 125, 18347.350000000002, 13795),
    (12, 406, 16296.490000000002, 12253),
    (13, 487, 9888.550000000001, 7435),
    (14, 62, 20851.74, 15678),
    (15, 22, 20007.190000000002, 15043),
    (16, 176, 7086.240000000001, 5328),
    (17, 361, 12152.210000000001, 9137),
    (18, 203, 12120.29, 9113),
    (19, 485, 12491.36, 9392),
    (20, 326, 21158.97, 15909),
    (21, 153, 13710.970000000001, 10309),
    (22, 204, 15792.42, 11874),
    (23, 134, 10041.5, 7550),
    (24, 415, 10674.58, 8026),
    (25, 117, 21141.68, 15896),
    (26, 166, 8783.32, 6604),
    (27, 210, 19399.38, 14586),
    (28, 127, 14119.28, 10616),
    (29, 345, 18302.13, 13761),
    (30, 430, 10262.28, 7716),
    (31, 496, 7700.700000000001, 5790),
    (32, 63, 8218.07, 6179),
    (33, 486, 14619.36, 10992),
    (34, 491, 12293.19, 9243)
;
