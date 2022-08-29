#include "CacheSim.h"
#include <stdio.h>

/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */
typedef struct{
	int tag;
	int valid;
}conjunt;

typedef struct {
	conjunt via[2];
	int LRU;
}associativa2;

associativa2 cache[64]; //(64*2)*32B = 4KB
int n_hit = 0;
int n_miss = 0;
/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
    totaltime=0.0;
	/* Escriu aqui el teu codi */

    //inicialitzar cache buida
    for (int i = 0; i < 64; ++i){
    	cache[i].via[0].valid = 0;
    	cache[i].via[1].valid = 0;
    }


}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int conj_mc;
	unsigned int via_mc;
	unsigned int tag;
	unsigned int miss;	   // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
	unsigned int tag_out;	   // TAG de la linia reemplaçada
	float t1,t2;		// Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */

	byte = address & (0x0000001F);	//obtenir ultims 5 bits accedits
    bloque_m = address >> 5;		// elimino 5 bits de menys pes
    conj_mc =(address & 0x000007E0) >> 5; // linea_mc = 0x7F, 6 bits de menys pes
    tag = address >> 11;			// obtenir tag => eliminar el 6 bits de menys pes


	if (cache[conj_mc].via[0].tag == tag && cache[conj_mc].via[0].valid == 1){
		++n_hit;
		via_mc = 0;
		cache[conj_mc].LRU = 1;
		miss = 0; 					
		replacement = 0;
	}
	else if (cache[conj_mc].via[1].tag == tag && cache[conj_mc].via[1].valid == 1){
		++n_hit;
		via_mc = 1;
		cache[conj_mc].LRU = 0;
		miss = 0; 					
		replacement = 0;
	}
	else{
		++n_miss;
		miss = 1;
		if (cache[conj_mc].via[0].valid == 0){ //mis per quan cache buida
			via_mc = 0;
			cache[conj_mc].via[0].valid = 1;
			cache[conj_mc].via[0].tag = tag;
			cache[conj_mc].LRU = 1;
			replacement = 0;
		}
		else if (cache[conj_mc].via[0].tag != tag){ //miss per quan no coincideixen tags
			if(cache[conj_mc].via[1].valid == 0){
				via_mc = 1;
				cache[conj_mc].via[via_mc].valid = 1;
				cache[conj_mc].via[0].tag = tag;
				cache[conj_mc].LRU = 0;
				replacement = 0;
			}
			else {
				int vies = cache[conj_mc].LRU;
				via_mc = vies;
				tag_out = cache[conj_mc].via[vies].tag;
				cache[conj_mc].via[vies].tag = tag;
				replacement = 1;
				if (via_mc == 0) cache[conj_mc].LRU = 1;
				else cache[conj_mc].LRU = 0;
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
  printf("Hits: %i\n Misses: %i\n", n_hit, n_miss);
}
