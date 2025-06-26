#include "TSubstance.h"
using namespace std;

TSubstance::TSubstance(string name, double ro)
{
	this->name = name;
	this->ro = ro;
}

string TSubstance::get_name() const
{
	return name;
}

double TSubstance::get_ro()
{
	return ro;
}

vector<TSubstance> substancje =
{
	TSubstance("woda", 997.8),
	TSubstance("mleko", 1030.0),
	TSubstance("oliwa", 920.0),
	TSubstance("krew", 1050.0)
};