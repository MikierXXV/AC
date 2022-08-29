#include "CacheSim.h"
#include <stdio.h>
/* Posa aqui les teves estructures de dades globals
 * per mantenir la informacio necesaria de la cache
 * */

int cache[128]; //128*32 = 4KB
int n_hit = 0;
int n_miss = 0;


/* La rutina init_cache es cridada pel programa principal per
 * inicialitzar la cache.
 * La cache es inicialitzada al començar cada un dels tests.
 * */
void init_cache ()
{
	/* Escriu aqui el teu codi */
	for (int i = 0; i < 128; i++) cache[i] = -1;

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

	byte = address & (0x0000001F);		//obtenir ultims 5 bits accedits
	bloque_m = address >> 5;			// elimino 5 bits de menys pes
	linea_mc = (address & 0x00000FE0) >> 5; 	// linea_mc = 0x7F, 7 bits de menys pes
	tag = address >> 12;				//obtenir tag => eliminar el 7 bits de menys pes

	miss = 0; 					
	replacement = 0;
	tag_out = -1;					// tag_out = -1  soritida per defecte

	lec_mp = 0;					
	esc_mp = 0;
	mida_lec_mp = -1;
	mida_esc_mp = -1;

	
	if (LE == escriptura){				// caso escritura
		esc_mp = 1;				//escribimos 
		mida_esc_mp = 1;			//mida 1B
		if(cache[linea_mc] == tag){ 		//caso de hit
			++n_hit;	
		}
		else {
			miss = 1;
			++n_miss;
		}
	}
	else if(LE == lectura){
		if(cache[linea_mc] == tag){
			++n_hit;
		}
		else{
			miss = 1;
			lec_mp = 1;
			mida_lec_mp = 32;
			++n_miss;
			if (cache[linea_mc] != -1){
				replacement = 1;
				tag_out = cache[linea_mc];
			}
			cache[linea_mc] = tag;
		}
	}



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
  	printf("Hits: %i\n Misses: %i\n", n_hit, n_miss);
  	
}
