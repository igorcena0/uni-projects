#pragma once
#include <iostream>
#include <vector>

#include "TSubstance.h"

class TCup
{
	std::vector<TSubstance> substances;
	std::vector<double> volumes;

public:
	void add(TSubstance substance, double volume_in_ml);
	void add(std::string name, double volume_in_ml);
	void add_vol(std::string name, double wanted_vol_coe);
	void show();

private:
	int get_substance_id(std::string name);
	int check(std::string name);
};