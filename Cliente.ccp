#include <iostream>
#include <stdlib.h>

using namespace std;

// Definición de la estructura Cliente
struct Cliente {
    int numeroCuenta;
    int tipoCuenta; // 1 para preferencial, 2 para tradicional
    Cliente* siguiente; // Puntero al siguiente cliente en la fila
};

// registrar un nuevo cliente
void registrarCliente(Cliente*& frente, Cliente*& final, int numCuenta, int tipoCuenta) {
    Cliente* nuevoCliente = new Cliente;
    nuevoCliente->numeroCuenta = numCuenta;
    nuevoCliente->tipoCuenta = tipoCuenta;
    nuevoCliente->siguiente = NULL;

    if (frente == NULL) { // La fila está vacía
        frente = nuevoCliente;
    } else {
        final->siguiente = nuevoCliente;
    }
    final = nuevoCliente;
}

// Función para verificar y realizar la transferencia de clientes entre filas si es necesario
void verificarTransferencia(Cliente*& tradicionalFrente, Cliente*& preferencialFrente, Cliente*& preferencialFinal) {
    if (¡tradicionalFrente != NULL && preferencialFrente != NULL) {
        int countTradicional = 0;
        int countPreferencial = 0;
        Cliente* temp = tradicionalFrente;
        while (temp != NULL) {
            countTradicional++;
            temp = temp->siguiente;
        }
        temp = preferencialFrente;
        while (temp != NULL) {
            countPreferencial++;
            temp = temp->siguiente;
        }

        if (countTradicional >= 5 && countPreferencial <= 2) {
            if (tradicionalFrente->siguiente != NULL && tradicionalFrente->siguiente->siguiente != NULL) {
                Cliente* tercerCliente = tradicionalFrente->siguiente->siguiente;
                tradicionalFrente->siguiente->siguiente = NULL; // Desconectar el tercer cliente de la fila tradicional
                preferencialFinal->siguiente = tercerCliente; // Conectar el tercer cliente de la fila tradicional a la fila preferencial
                preferencialFinal = tercerCliente; // Actualizar el puntero al último cliente en la fila preferencial
            }
        }
    }
}

// Función para mostrar los clientes en la fila
void mostrarClientes(Cliente* frente, const string& tipoFila) {
    Cliente* actual = frente;
    int turno = 1;
    cout << "Clientes en la fila " << tipoFila << ":" << endl;
    while (actual != NULL) {
        cout << "Turno " << turno << ": ";
        cout << "Cuenta: " << actual->numeroCuenta << " Tipo: " << actual->tipoCuenta << endl;
        actual = actual->siguiente;
        turno++;
    }
}

// Funcion para atender al siguiente cliente y sacarlo de la fila
void atenderCliente(Cliente*& frente) {
    if (frente != NULL) {
        Cliente* temp = frente;
        frente = frente->siguiente;
        delete temp;
    } else {
        cout << "No hay clientes en la fila" << endl;
    }
}

// Función para reasignar los turnos de los clientes en la fila
void reasignarTurnos(Cliente* frente) {
    Cliente* actual = frente;
    int turno = 1;
    while (actual != NULL) {
        turno++;
        actual = actual->siguiente;
    }
}

int main() {
    Cliente* tradicionalFrente = NULL;
    Cliente* tradicionalFinal = NULL;
    Cliente* preferencialFrente = NULL;
    Cliente* preferencialFinal = NULL;

    int opc = 0;
    do {
        cout << "1. Registrar cliente tradicional" << endl;
        cout << "2. Registrar cliente preferencial" << endl;
        cout << "3. Mostrar clientes en la fila tradicional" << endl;
        cout << "4. Mostrar clientes en la fila preferencial" << endl;
        cout << "5. Atender cliente en la fila tradicional" << endl;
        cout << "6. Atender cliente en la fila preferencial" << endl;
        cout << "7. Salir" << endl;
        cout << "Ingrese su opción: ";
        cin >> opc;

        switch (opc) {
            case 1:
                int numCuenta;
                cout << "Ingrese el número de cuenta: ";
                cin >> numCuenta;
                registrarCliente(tradicionalFrente, tradicionalFinal, numCuenta, 2);
                verificarTransferencia(tradicionalFrente, preferencialFrente, preferencialFinal);
                break;
            case 2:
                cout << "Ingrese el número de cuenta: ";
                cin >> numCuenta;
                registrarCliente(preferencialFrente, preferencialFinal, numCuenta, 1);
                break;
            case 3:
                mostrarClientes(tradicionalFrente, "tradicional");
                break;
            case 4:
                mostrarClientes(preferencialFrente, "preferencial");
                break;
            case 5:
                atenderCliente(tradicionalFrente);
                reasignarTurnos(tradicionalFrente);
                break;
            case 6:
                atenderCliente(preferencialFrente);
                reasignarTurnos(preferencialFrente);
                break;
            case 7:
                cout << "Saliendo del programa..." << endl;
                break;
            default:
                cout << "Opción inválida. Intente de nuevo." << endl;
        }
    } while (opc != 7);

    return 0;
}
