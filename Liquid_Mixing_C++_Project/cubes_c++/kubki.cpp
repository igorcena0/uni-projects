#include <iostream>
#include <vector>
#include "TSubstance.h"
#include "TCup.h"
using namespace std;

int main()
{
	cout << "Hello world!\n";

	TCup kubek1;
	kubek1.add(substancje[0], 73);
	kubek1.add(substancje[2], 53);
	kubek1.add(substancje[1], 162);
	kubek1.add("kwas", 1);
	kubek1.add("woda", 54);
	kubek1.add("mleko", 27);
	kubek1.show();
	kubek1.add_vol("woda", 40);
	kubek1.add_vol("mleko", 40);
}