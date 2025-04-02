#pragma once
#include <iostream>
#include <vector>

class TSubstance
{
	std::string name;
	double		ro;

public:
	TSubstance(std::string name, double ro);

	std::string get_name();
	double		get_ro();
};

extern std::vector<TSubstance> substancje;