// (c) FIBerHub, https://fiberhub.tk

#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
 struct linea{
     int tag;
     int dirty;
};

struct linea cache[128];

int hit_num = 0;
int miss_num = 0;

/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    /* Escriu aqui el teu codi */
    for (int i = 0; i < 128; i++) {
        cache[i].tag = -1;
        cache[i].dirty = false;
    }
}

/* La rutina reference es cridada per cada referencia a simular */
void reference (unsigned int address, unsigned int LE)
{
    unsigned int byte;
    unsigned int bloque_m;
    unsigned int linea_mc;
    unsigned int tag;
    unsigned int miss;
    unsigned int lec_mp;
    unsigned int mida_lec_mp;
    unsigned int esc_mp;
    unsigned int mida_esc_mp;
    unsigned int replacement;
    unsigned int tag_out;

    /* Escriu aqui el teu codi */
    byte = address%32;
    bloque_m = address/32;
    linea_mc = bloque_m%128;
    tag = bloque_m/128;

    miss = false;
    replacement = false;
    tag_out = 0;

    lec_mp = false;
    esc_mp = false;

    if (cache[linea_mc].tag != tag) {
        ++miss_num;
        miss = true;
        lec_mp = true;
        mida_lec_mp = 32;

        if (cache[linea_mc].tag != -1) {
            replacement = true;
            if (cache[linea_mc].dirty) {
                esc_mp = true;
                mida_esc_mp = 32;
                cache[linea_mc].dirty = false;
            }
            tag_out = cache[linea_mc].tag;
        }
        cache[linea_mc].tag = tag;

    } else ++hit_num;

    if (LE == escriptura) cache[linea_mc].dirty = true;

    /* La funcio test_and_print escriu el resultat de la teva simulacio
     * per pantalla (si s'escau) i comproba si hi ha algun error
     * per la referencia actual
     * */
    test_and_print (address, LE, byte, bloque_m, linea_mc, tag,
            miss, lec_mp, mida_lec_mp, esc_mp, mida_esc_mp,
            replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */
void final ()
{
    /* Escriu aqui el teu codi */
    printf("Aciertos: %i\nFallos: %i\n", hit_num, miss_num);
}
