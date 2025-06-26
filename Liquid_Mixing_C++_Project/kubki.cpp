#include <iostream>
#include <vector>
#include "TSubstance.h"
#include "TCup.h"
using namespace std;

int main()
{
	TCup kubek1, kubek2;
	kubek1.add("woda", 100);
	kubek1.add("mleko", 50);
	kubek1.add(substancje[1], 100);
	kubek1.add("krew", 50);
	kubek1.show();
	kubek1.add_vol(substancje[0], 99);
	kubek2.add(substancje[2], 125);
	kubek2.add("woda", 30);
	kubek2.show();
	kubek1.merge(kubek2);
	kubek1.show();
	kubek2.show();
}