#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
typedef struct {
    unsigned int v; // bit de validesa
    int tag;
} S_via;

typedef struct {        // 2 associativa -> 2 vies
    S_via via[2];
    unsigned int lru;   // 0 o 1 
} conjunt;

conjunt cache[64];

int hits;
int misses;

/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
    for(int i=0; i<64; ++i){
        cache[i].via[0].v = 0;
        cache[i].via[1].v = 0;
    }
    hits=0;
    misses=0;
    


}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
    unsigned int byte;
    unsigned int bloque_m; 
    unsigned int conj_mc;
    unsigned int via_mc;
    unsigned int tag;
    unsigned int miss;     // boolea que ens indica si es miss
    unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
    unsigned int tag_out;      // TAG de la linia reemplaçada
    float t1,t2;        // Variables per mesurar el temps (NO modificar)
    
    t1=GetTime();
    /* Escriu aqui el teu codi */


    byte = address & (0x0000001F);
    bloque_m = address >> 5;
    conj_mc =(address & 0x000007E0) >> 5; // linea_mc = 0x7F
    tag = address >> 11;

    if(cache[conj_mc].via[0].v == 1 && cache[conj_mc].via[0].tag == tag){
        //hem fet hit
        ++hits;
        miss = 0;
        replacement = 0;
        via_mc = 0;
        cache[conj_mc].lru = 1;
    }
    else if (cache[conj_mc].via[1].v == 1 && cache[conj_mc].via[1].tag == tag){
        //hem fet hit
        ++hits;
        miss = 0;
        replacement = 0;
        via_mc = 1;
        cache[conj_mc].lru = 0;

    }
    else { 
        //hem fet miss
        miss = 1;
        ++misses;
        if(cache[conj_mc].via[0].v == 0){
            cache[conj_mc].via[0].v = 1; //bit validesa 1
            via_mc = 0;
            cache[conj_mc].lru = 1;
            cache[conj_mc].via[0].tag = tag;
            replacement = 0;
        }
        else if(cache[conj_mc].via[0].tag != tag){
            if(cache[conj_mc].via[1].v == 0){
                via_mc = 1;
                cache[conj_mc].lru = 0;
                cache[conj_mc].via[1].tag = tag;
                replacement = 0;
                cache[conj_mc].via[via_mc].v = 1;
            }
            else{
                int quina_via = cache[conj_mc].lru;
                tag_out = cache[conj_mc].via[quina_via].tag;
                replacement = 1;
                cache[conj_mc].via[quina_via].tag = tag;
                via_mc = quina_via;
                if (via_mc == 1) cache[conj_mc].lru = 0;
                else cache[conj_mc].lru = 1;

            }
        }
    }


    /* La funcio test_and_print escriu el resultat de la teva simulacio
     * per pantalla (si s'escau) i comproba si hi ha algun error
     * per la referencia actual. També mesurem el temps d'execució
     * */
    t2=GetTime();
    totaltime+=t2-t1;
    test_and_print2 (address, byte, bloque_m, conj_mc, via_mc, tag,
            miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
    /* Escriu aqui el teu codi */ 
    printf("Encerts: %d. Fallades: %d\n", hits, misses);
  
}