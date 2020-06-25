//Models
import 'package:decker/models/Carta.dart';
import 'package:decker/models/Mazo.dart';

class DB {
  static getCartas() {
    return [
      Carta(
        id: 1,
        nombre: "Alberich",
        pathImage: "https://api.myl.cl/static/cards/35/014.png",
        fuerza: 3,
        coste: 2,
        edicion: 2,
        tipoCarta: 0,
        raza: 1,
        frecuencia: 0,
        habilidad: "Una vez por turno, si sólo controlas Faeries, puedes buscar en tu Castillo un Talismán de coste 1 o más, jugarlo reduciendo su coste en 1 o ponerlo en tu mano. Los Aliados oponentes de Fuerza 0 pierden su habilidad",
        atributos: ["Errante", "Indesterrable"]
      ),
      Carta(
        id: 2,
        nombre: "Huanglong",
        pathImage: "https://api.myl.cl/static/cards/36/004.png",
        fuerza: 7,
        coste: 4,
        edicion: 3,
        tipoCarta: 0,
        raza: 2,
        frecuencia: 0,
        habilidad: "Si solocontrolas Dragones, puedes padar dos Oros y Botar cinco cartas para jugar este Aliado desde tu cementerio sin pagar su coste. Cuando entra en juego, juega el Dragón objetivo de tu Cementerio, de coste 4 0 menos, sin pagar su coste.",
        atributos: ["Errante", "Inmunidad - Talismanes"]
      ),
      Carta(
        id: 3,
        nombre: "Morbo Gótico",
        pathImage: "https://api.myl.cl/static/cards/35/019.png",
        fuerza: null,
        coste: 3,
        edicion: 2,
        tipoCarta: 1,
        raza: null,
        frecuencia: 0,
        habilidad: "Cuando juegues este Talismán, Destiérralo. Te cuesta un Oro menos jugar este Talismán por cada Aliado que controles y/o muestres de tu mano de una misma Raza. Anula una carta oponente. Luego, Destierra esa carta.",
        atributos: ["Única",]
      ),
      Carta(
        id: 4,
        nombre: "Pa Kua",
        pathImage: "https://api.myl.cl/static/cards/36/016.png",
        fuerza: null,
        coste: null,
        edicion: 3,
        tipoCarta: 3,
        raza: null,
        frecuencia: 0,
        habilidad: "Si está en tu Cementerio, puedes Desterrar otras dos cartas de tu Cementerio y ponerlo en tu Zona de Oro Pagado. En tu Vigilia, si está en tu Reserva, puedes buscar un Oro en tu Castillo, que no sea Pa kua, y ponerlo en tu Cementerio o mano.",
        atributos: []
      ),
      Carta(
        id: 5,
        nombre: "Nüwa",
        pathImage: "https://api.myl.cl/static/cards/36/019.png",
        fuerza: 1,
        coste: 1,
        edicion: 3,
        tipoCarta: 0,
        raza: 3,
        frecuencia: 1,
        habilidad: "Si solo constrolas Ancestrales, puedes Desterrar este y otro Ancestral de tu mano para Anular un Talimán oponente de coste 2 o menos. Cuando entra en juego si solo controlas Ancestrales, Destruye hasta dos cartas objetivo de coste 1 o menos que no sean Oro.",
        atributos: []
      ),
      Carta(
        id: 6,
        nombre: "Fang La",
        pathImage: "https://api.myl.cl/static/cards/36/030.png",
        fuerza: 3,
        coste: 1,
        edicion: 3,
        tipoCarta: 0,
        raza: 4,
        frecuencia: 1,
        habilidad: "No puede perder su habilidad. En tu Vigilia, Baraja un Bárbaro que controles para Barajar una carta oponente del mismo o menor coste. Hasta dos veces por turno, puedes Desterrar una carta objetivo de un Cementerio.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 7,
        nombre: "Lyngbakur",
        pathImage: "https://api.myl.cl/static/cards/35/009.png",
        fuerza: 3,
        coste: 2,
        edicion: 2,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "Cuando entra en juego, si sólo controlas Bestias, Destruye la carta oponente objetivo que no sea Oro. En tu Vigilia, una vez por turno, si está en tu Cementerio, puedes crear una Bestia de Fuerza 2 con Furia.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 8,
        nombre: "Beerwolf",
        pathImage: "https://api.myl.cl/static/cards/34/003.png",
        fuerza: 3,
        coste: 2,
        edicion: 1,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "En tu Fase de Vigilia, puedes quitar un contador de Alimento de un Aliado que controles para poner este Aliado en juego desde tu Cementerio. Cuando ataca, puedes poner hasta dos contadores de Alimento en otros Aliados Oscuridad o Bestia.",
        atributos: ["Oscuridad","Furia"]
      ),
      Carta(
        id: 9,
        nombre: "Olitiau",
        pathImage: "https://api.myl.cl/static/cards/31/018.png",
        fuerza: 2,
        coste: 1,
        edicion: 0,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 1,
        habilidad: "Cuando Descartes este Aliado ñandú, juégalo sin pagar su coste. Cuando ataca, Roba una carta y Descarta una carta. Si Descartas una Bestia, este Aliado gana 2 de Fuerza y es Indestructible hasta la Fase Final.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 10,
        nombre: "Tortuga Negra",
        pathImage: "https://api.myl.cl/static/cards/36/010.png",
        fuerza: 3,
        coste: 2,
        edicion: 3,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "Cuando entra en juego o sea Descartado, si sólo controlas Bestias, crea dos Bestias de Fuerza 2. Puedes quitar un contador de Alimento de una Bestia que controles o Destruir una Bestia que controles para Robar dos cartas",
        atributos: ["Furia", "Inmunidad - Aliados oponentes"]
      ),
      Carta(
        id: 11,
        nombre: "Alberich 2",
        pathImage: "https://api.myl.cl/static/cards/35/014.png",
        fuerza: 3,
        coste: 2,
        edicion: 2,
        tipoCarta: 0,
        raza: 1,
        frecuencia: 0,
        habilidad: "Una vez por turno, si sólo controlas Faeries, puedes buscar en tu Castillo un Talismán de coste 1 o más, jugarlo reduciendo su coste en 1 o ponerlo en tu mano. Los Aliados oponentes de Fuerza 0 pierden su habilidad",
        atributos: ["Errante", "Indesterrable"]
      ),
      Carta(
        id: 12,
        nombre: "Huanglong 2",
        pathImage: "https://api.myl.cl/static/cards/36/004.png",
        fuerza: 7,
        coste: 4,
        edicion: 3,
        tipoCarta: 0,
        raza: 2,
        frecuencia: 0,
        habilidad: "Si solocontrolas Dragones, puedes padar dos Oros y Botar cinco cartas para jugar este Aliado desde tu cementerio sin pagar su coste. Cuando entra en juego, juega el Dragón objetivo de tu Cementerio, de coste 4 0 menos, sin pagar su coste.",
        atributos: ["Errante", "Inmunidad - Talismanes"]
      ),
      Carta(
        id: 13,
        nombre: "Morbo Gótico 2",
        pathImage: "https://api.myl.cl/static/cards/35/019.png",
        fuerza: null,
        coste: 3,
        edicion: 2,
        tipoCarta: 1,
        raza: null,
        frecuencia: 0,
        habilidad: "Cuando juegues este Talismán, Destiérralo. Te cuesta un Oro menos jugar este Talismán por cada Aliado que controles y/o muestres de tu mano de una misma Raza. Anula una carta oponente. Luego, Destierra esa carta.",
        atributos: ["Única",]
      ),
      Carta(
        id: 14,
        nombre: "Pa Kua 2",
        pathImage: "https://api.myl.cl/static/cards/36/016.png",
        fuerza: null,
        coste: null,
        edicion: 3,
        tipoCarta: 3,
        raza: null,
        frecuencia: 0,
        habilidad: "Si está en tu Cementerio, puedes Desterrar otras dos cartas de tu Cementerio y ponerlo en tu Zona de Oro Pagado. En tu Vigilia, si está en tu Reserva, puedes buscar un Oro en tu Castillo, que no sea Pa kua, y ponerlo en tu Cementerio o mano.",
        atributos: []
      ),
      Carta(
        id: 15,
        nombre: "Nüwa 2",
        pathImage: "https://api.myl.cl/static/cards/36/019.png",
        fuerza: 1,
        coste: 1,
        edicion: 3,
        tipoCarta: 0,
        raza: 3,
        frecuencia: 1,
        habilidad: "Si solo constrolas Ancestrales, puedes Desterrar este y otro Ancestral de tu mano para Anular un Talimán oponente de coste 2 o menos. Cuando entra en juego si solo controlas Ancestrales, Destruye hasta dos cartas objetivo de coste 1 o menos que no sean Oro.",
        atributos: []
      ),
      Carta(
        id: 16,
        nombre: "Fang La 2",
        pathImage: "https://api.myl.cl/static/cards/36/030.png",
        fuerza: 3,
        coste: 1,
        edicion: 3,
        tipoCarta: 0,
        raza: 4,
        frecuencia: 1,
        habilidad: "No puede perder su habilidad. En tu Vigilia, Baraja un Bárbaro que controles para Barajar una carta oponente del mismo o menor coste. Hasta dos veces por turno, puedes Desterrar una carta objetivo de un Cementerio.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 17,
        nombre: "Lyngbakur 2",
        pathImage: "https://api.myl.cl/static/cards/35/009.png",
        fuerza: 3,
        coste: 2,
        edicion: 2,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "Cuando entra en juego, si sólo controlas Bestias, Destruye la carta oponente objetivo que no sea Oro. En tu Vigilia, una vez por turno, si está en tu Cementerio, puedes crear una Bestia de Fuerza 2 con Furia.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 18,
        nombre: "Beerwolf 2",
        pathImage: "https://api.myl.cl/static/cards/34/003.png",
        fuerza: 3,
        coste: 2,
        edicion: 1,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "En tu Fase de Vigilia, puedes quitar un contador de Alimento de un Aliado que controles para poner este Aliado en juego desde tu Cementerio. Cuando ataca, puedes poner hasta dos contadores de Alimento en otros Aliados Oscuridad o Bestia.",
        atributos: ["Oscuridad","Furia"]
      ),
      Carta(
        id: 19,
        nombre: "Olitiau 2",
        pathImage: "https://api.myl.cl/static/cards/31/018.png",
        fuerza: 2,
        coste: 1,
        edicion: 0,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 1,
        habilidad: "Cuando Descartes este Aliado ñandú, juégalo sin pagar su coste. Cuando ataca, Roba una carta y Descarta una carta. Si Descartas una Bestia, este Aliado gana 2 de Fuerza y es Indestructible hasta la Fase Final.",
        atributos: ["Furia"]
      ),
      Carta(
        id: 20,
        nombre: "Tortuga Negra 2",
        pathImage: "https://api.myl.cl/static/cards/36/010.png",
        fuerza: 3,
        coste: 2,
        edicion: 3,
        tipoCarta: 0,
        raza: 5,
        frecuencia: 0,
        habilidad: "Cuando entra en juego o sea Descartado, si sólo controlas Bestias, crea dos Bestias de Fuerza 2. Puedes quitar un contador de Alimento de una Bestia que controles o Destruir una Bestia que controles para Robar dos cartas",
        atributos: ["Furia", "Inmunidad - Aliados oponentes"]
      ),
      Carta(
        id: 21,
        nombre: "Santuario Yoruba",
        pathImage: "https://api.myl.cl/static/cards/36/267.png",
        fuerza: null,
        coste: 2,
        edicion: 1,
        tipoCarta: 5,
        raza: null,
        frecuencia: 5,
        habilidad: "Para construir este Monumento debes tener seis o más cartas en tu Cementerio. Construcción: Pon un Aliado de tu Cementerio de Fuerza 4 o menos en juego. Progreso: Si dos o más cartas fueron puestas en tu Cementerio este turno, pon un contador de tiempo sobre este Monumento. Finalización: Las cartas en tu Cementerio tienen Exhumar hasta la Fase Final.",
        atributos: ["Furia", "Inmunidad - Aliados oponentes"]
      ),
      
    ];
  }

  static getRazas() {
    return [
      {"id": 0, "nombre": "Ninguna"}, 
      {"id": 1, "nombre": "Faerie"},
      {"id": 2, "nombre": "Dragon"},
      {"id": 3, "nombre": "Ancestra"},
      {"id": 4, "nombre": "Bárbaro"},
      {"id": 5, "nombre": "Bestia"},
    ];
  }

  static getEdiciones() {
    return [
      {"id": 1, "nombre": "Kilimanjaro"},
      {"id": 2, "nombre": "Terrores Nocturnos"},
      {"id": 3, "nombre": "Invación Oscura"},
      {"id": 4, "nombre": "Dinastía del Dragón"},
    ];
  }

  static getTipoCartas() {
    return [
      {"id": 1, "nombre": "Aliado"},
      {"id": 2, "nombre": "Talisman"},
      {"id": 3, "nombre": "Arma"},
      {"id": 4, "nombre": "Totem"},
      {"id": 5, "nombre": "Oro"},
      {"id": 6, "nombre": "Monumento"},
    ];
  }

  static getFrecuencias() {
    return [
      {"id": 1, "nombre": "Ultra Real"},
      {"id": 2, "nombre": "Mega Real"},
      {"id": 3, "nombre": "Real"},
      {"id": 4, "nombre": "Cortesano"},
      {"id": 5, "nombre": "Vasallo"},
      {"id": 6, "nombre": "Promo"},
    ];
  }

  static getMazos() {
    return [
      Mazo(
        id: 1,
        nombre: "Mazo faerie mix",
        formato: "Imperio",
        main: [
          {"id": 1, "amount" : 3},
          {"id": 2, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},

          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 3},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 2},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 2,
        nombre: "Mazo bestia mix",
        formato: "Imperio",
        main: [
          {"id": 7, "amount" : 3},
          {"id": 2, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 3,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 4,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 5,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 6,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 7,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      ),
      Mazo(
        id: 8,
        nombre: "Mazo dragon mix",
        formato: "Imperio",
        main: [
          {"id": 2, "amount" : 3},
          {"id": 1, "amount" : 3},
          {"id": 3, "amount" : 3},
          {"id": 4, "amount" : 3},
          {"id": 5, "amount" : 3},
          {"id": 6, "amount" : 3},
          {"id": 7, "amount" : 3},
          {"id": 8, "amount" : 3},
          {"id": 9, "amount" : 3},
          {"id": 10, "amount" : 3},
          {"id": 11, "amount" : 3},
          {"id": 12, "amount" : 3},
          {"id": 13, "amount" : 2},
          {"id": 14, "amount" : 3},
          {"id": 15, "amount" : 3},
          {"id": 16, "amount" : 3},
          {"id": 17, "amount" : 3},
        ],
        side: [
          {"id": 18, "amount" : 5},
          {"id": 19, "amount" : 5},
        ],
        monument: 21
      )
    ];
  }

}