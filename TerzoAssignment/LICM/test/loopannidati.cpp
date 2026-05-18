#include <iostream>
#include <cmath>
// test con loop annidati
int main(){
  const int n=200; //Dimensione dei loop
  int a=1;
  int b=2;
  int d=0;
  for (int i=0; i<n; ++i) {
    // istruzione loop invariant
    int c=a+b;
    

    int j = 0;
    do {
      // loop-invariant per il ciclo j, 
      // non viene spostata in quanto non tutti i suoi operandi verranno spostati (è presente una phi) (da consegna)
      int sommaA = i+a;
      // loop invariant
      int doppioA=a*2;
      int k=0;
      do {
        // loop invariant per il ciclo k 
        int sommaB=(b+j);
        int sommaC=(c+k);
        int radici=sommaA+sommaB;
        k++;
      } while(k<n);
      j++;
    } while(j<n);
  
  }

  int x = d + 1;
}
