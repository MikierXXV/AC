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
    totaltime=0.0;
	/* Escriu aqui el teu codi */

    for (int i = 0; i < 128; i++) cache[i] = -1;

}

/* La rutina reference es cridada per cada referencia a simular */ 
void reference (unsigned int address)
{
	unsigned int byte;
	unsigned int bloque_m; 
	unsigned int linea_mc;
	unsigned int tag;
	unsigned int miss;	       // boolea que ens indica si es miss
	unsigned int replacement;  // boolea que indica si es reemplaça una linia valida
	unsigned int tag_out;	   // TAG de la linia reemplaçada
	float t1,t2;			   // Variables per mesurar el temps (NO modificar)
	
	t1=GetTime();
	/* Escriu aqui el teu codi */
	
	byte = address & (0x0000001F);	//obtenir ultims 5 bits accedits
	bloque_m = address >> 5;		// elimino 5 bits de menys pes
	linea_mc = (address & 0x00000FE0) >> 5; // linea_mc = 0x7F, 7 bits de menys pes
	tag = address >> 12;			//obtenir tag => eliminar el 7 bits de menys pes

	miss = 0; 					
	replacement = 0;
	tag_out = -1;				// tag_out = -1  soritida per defecte

	
	if (cache[linea_mc] == tag) {
        ++n_hit;				//obtenemos hit si el tag ==
    }
	else {	
		++n_miss;				//obtenemos miss si el tag !=			
		miss = 1;	
		if (cache[linea_mc] != -1) {
			replacement = 1;
			tag_out = cache[linea_mc];
		}
        cache[linea_mc] = tag;
    }

	/* La funcio test_and_print escriu el resultat de la teva simulacio
	 * per pantalla (si s'escau) i comproba si hi ha algun error
	 * per la referencia actual. També mesurem el temps d'execució
	 * */
	t2=GetTime();
	totaltime+=t2-t1;
	test_and_print (address, byte, bloque_m, linea_mc, tag,
			miss, replacement, tag_out);
}

/* La rutina final es cridada al final de la simulacio */ 
void final ()
{
 	/* Escriu aqui el teu codi */
 	printf("Hits: %i\n Misses: %i\n", n_hit, n_miss); 
  
  
}
