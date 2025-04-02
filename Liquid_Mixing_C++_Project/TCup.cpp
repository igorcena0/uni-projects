#include "TCup.h"
using namespace std;

void TCup::add(TSubstance substance, double volume_in_ml)
{
	string name = substance.get_name();
	int _id1 = check(name);
	if (_id1 == -1)
	{
		substances.push_back(substance);
		volumes.push_back(volume_in_ml / 1e6);
	}
	else
	{
		volumes[_id1] += volume_in_ml / 1e6;
	}
}

void TCup::add(std::string name, double volume_in_ml)
{
	int _id = get_substance_id(name);
	int _id1 = check(name);

	if (_id1 == -1)
	{
		if (_id >= 0)
		{
			this->add(substancje[_id], volume_in_ml);
		}
		// zeby dodac nieznana substancje
	/*	else
		{
			double density;
			cout << "Podaj gestosc nowej substancji \"" << name << "\" w kg/m³: ";
			cin >> density;

			TSubstance new_substance(name, density);
			substancje.push_back(new_substance);

			this->add(new_substance, volume_in_ml);
		}*/
	}
	else
	{
		volumes[_id1] += volume_in_ml / 1e6;
	}
}

void TCup::add_vol(std::string name, double wanted_vol_coe)
{
	int _id1 = check(name);

	if (_id1 == -1)
	{
		cout << "\nTakiej substancji nie ma obecnie w kubku\n" << endl;
		return;
	}

	size_t count = substances.size();
	if (count == 1)
	{
		cout << "\nW kubku znajduje sie tylko podana substancja, co uniemozliwia nadanie procentowego udzialu objetosciowego substancji\n" << endl;
		return;
	}

	if (wanted_vol_coe == 100 && count>1)
	{
		cout << "\nW kubku znajduje sie wiecej niz jedna substancja, co uniemozliwia nadania 100% udzialu objetosciowego substancji\n" << endl;
		return;
	}

	if (wanted_vol_coe > 100 || wanted_vol_coe < 0)
	{
		cout << "\nZadany procent udzialu objetosciowego substancji w kubku musi zawierac sie w przedziale 0-100%\n" << endl;
		return;
	}

	double volume_sum = 0;
	for (int i = 0; i < count; i++)
	{
		volume_sum += volumes[i];
	}

	double current_vol_coe = (volumes[_id1] / volume_sum) * 100;

	if (current_vol_coe == wanted_vol_coe)
	{
		cout << "\nSubstancja " << name << " ma wymagany procentowy udzial objetosciowy\n" << endl;
		return;
	}

	if (current_vol_coe > wanted_vol_coe && (wanted_vol_coe > 0 && wanted_vol_coe < 100))
	{
		cout << "\nSubstancja " << name << " ma wyzszy procentowy udzial objetosciowy niz zadany\n" << endl;
		return;
	}

	else
	{
		double required_volume = (wanted_vol_coe * volume_sum - 100 * volumes[_id1]) / (100 - wanted_vol_coe);
		cout << "\nW celu osiagniecia " << wanted_vol_coe << "% udzialu objetosciowego substancji " << name << " w kubku, dolewam " << required_volume * 1e6 << " ml tej substancji do kubka\n" << endl;
		volumes[_id1] += required_volume;
		TCup::show();
	}
	}

int TCup::check(string name)
{
	size_t count = substances.size();

	for (int i = 0; i < count; i++)
	{
		if (substances[i].get_name() == name)
		{
			return i;
		}
	}
	return -1;
}

int TCup::get_substance_id(string name)
{
	int count = substancje.size();
	for (size_t i = 0; i < count; i++)
	{
		if (substancje[i].get_name() == name)
		{
			return i;
		}
	}
	cout << "Nie znaleziono plynu o nazwie: \"" << name << "\"!\n";
	return -1;
}

void TCup::show()
{
	size_t count = substances.size();
	double volume_sum = 0;
	double mass_sum = 0;
	for (int i = 0; i < substances.size(); i++)
	{
		volume_sum += volumes[i];
		mass_sum += substances[i].get_ro() * volumes[i] * 1000;
	}
	cout << "Substancje wlane do kubka:" << endl;
	for (int i = 0; i < count; i++)
	{
		double mass = substances[i].get_ro() * volumes[i] * 1000; //grams
		double volume_coe = (volumes[i] / volume_sum) * 100;
		double mass_coe = (mass / mass_sum) * 100;

		cout << i+1 << ". " << substances[i].get_name() << " -"
			<< " volume: " << volumes[i] * 1e6 << "ml;"
			<< " mass: " << mass << "g;"
			<< " volume coe: " << volume_coe << "%;"
			<< " mass coe: " << mass_coe << "%" << endl;
	}
}