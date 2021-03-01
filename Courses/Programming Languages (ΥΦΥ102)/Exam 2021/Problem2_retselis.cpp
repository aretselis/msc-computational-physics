#include <iostream>

class Atom{
    private:
        int nP;
        int nX;
    public:
        Atom(int nP, int nX){
            this->nP = nP;
            this->nX = nX;
        }
        
        void set_nP(int nP){
            this->nP = nP;
        }
        
        void set_nX(int nX){
            this->nX = nX;
        }
        
        int get_nP(){
            return nP;
        }
        
        int get_nX(){
            return nX;
        }
        int get_mass_number(){
        	return nP+nX;
		}
};

class DiatomicElement{
    private:
        Atom atom;
    public:
        DiatomicElement(Atom& atom):atom(atom){}
        
        int total_P_X(){
            return atom.get_mass_number()+atom.get_mass_number();
        }
};

int main()
{
    Atom Oxygen(8,8);
    std::cout << "Atomic mass = "<< Oxygen.get_mass_number() << "\n";
    
    DiatomicElement O2(Oxygen);
    std::cout << "Total mass = " << O2.total_P_X() << "\n";
}
