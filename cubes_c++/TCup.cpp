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

void TCup::add_vol(TSubstance substance, double wanted_vol_coe)
{
	cout << "\nOperacja: Ustawianie " << wanted_vol_coe << "% udzialu objetosciowego dla substancji: "
		<< substance.get_name() << endl;

	if (substances.empty())
	{
		cout << "\nKubek jest pusty. Dodaj substancje przed proba zmiany jej udzialu objetosciowego.\n" << endl;
		return;
	}

	std::string name = substance.get_name();
	int _id1 = check(name);

	if (_id1 == -1)
	{
		cout << "\nSubstancji " << name << " nie ma obecnie w kubku. Dolewam ja do kubka.\n" << endl;
		this->add(substance, 0.001);
		_id1 = check(name);
	}

	size_t count = substances.size();
	if (count == 1)
	{
		cout << "\nW kubku znajduje sie tylko podana substancja, co uniemozliwia nadanie jej procentowego udzialu objetosciowego\n" << endl;
		return;
	}

	if (wanted_vol_coe == 100 && count > 1)
	{
		cout << "\nW kubku znajduje sie wiecej niz jedna substancja, co uniemozliwia nadania 100% udzialu objetosciowego substancji\n" << endl;
		return;
	}

	if (wanted_vol_coe > 100 || wanted_vol_coe < 0)
	{
		cout << "\nZadany procent udzialu objetosciowego substancji w kubku musi zawierac sie w przedziale 0-100%\n" << endl;
		return;
	}
	if (wanted_vol_coe == 0)
	{
		cout << "\nNie mozna nadac 0% udzialu objetosciowego substancji\n" << endl;
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

	double required_volume = (wanted_vol_coe * volume_sum - 100 * volumes[_id1]) / (100 - wanted_vol_coe);
	cout << "\nW celu osiagniecia " << wanted_vol_coe << "% udzialu objetosciowego substancji " << name << " w kubku, dolewam " << required_volume * 1e6 << " ml tej substancji do kubka" << endl;
	volumes[_id1] += required_volume;
	TCup::show();
}


void TCup::add_vol(std::string name, double wanted_vol_coe)
{
	cout << "\nOperacja: Ustawianie " << wanted_vol_coe << "% udzialu objetosciowego dla substancji: "
		<< name << endl;

	if (substances.empty())
	{
		cout << "\nKubek jest pusty. Dodaj substancje przed proba zmiany jej udzialu objetosciowego.\n" << endl;
		return;
	}
	int _id1 = check(name);

	if (_id1 == -1)
	{
		cout << "\nSubstancji " << name << " nie ma obecnie w kubku. Dolewam ja do kubka.\n" << endl;
		int _id = get_substance_id(name);
		if (_id >= 0)
		{
			this->add(substancje[_id], 0.001);
		}
		else
		{
			cout << "\nSubstancji " << name << " nie mozna dolac, poniewaz nie zostala wczesniej zdefiniowana.\n" << endl;
			return;
		}
		_id1 = check(name);
	}

	size_t count = substances.size();
	if (count == 1)
	{
		cout << "\nW kubku znajduje sie tylko podana substancja, co uniemozliwia nadanie jej procentowego udzialu objetosciowego\n" << endl;
		return;
	}

	if (wanted_vol_coe == 100 && count > 1)
	{
		cout << "\nW kubku znajduje sie wiecej niz jedna substancja, co uniemozliwia nadania 100% udzialu objetosciowego substancji\n" << endl;
		return;
	}

	if (wanted_vol_coe > 100 || wanted_vol_coe < 0)
	{
		cout << "\nZadany procent udzialu objetosciowego substancji w kubku musi zawierac sie w przedziale 0-100%\n" << endl;
		return;
	}

	if (wanted_vol_coe == 0)
	{
		cout << "\nNie mozna nadac 0% udzialu objetosciowego substancji\n" << endl;
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
		cout << "\nW celu osiagniecia " << wanted_vol_coe << "% udzialu objetosciowego substancji " << name << " w kubku, dolewam " << required_volume * 1e6 << " ml tej substancji do kubka" << endl;
		volumes[_id1] += required_volume;
		TCup::show();
	}
}

void TCup::add_mass(TSubstance substance, double wanted_mass_coe)
{
	cout << "\nOperacja: Ustawianie " << wanted_mass_coe << "% udzialu masowego dla substancji: "
		<< substance.get_name() << endl;

	if (substances.empty())
	{
		cout << "\nKubek jest pusty. Dodaj substancje przed proba zmiany jej udzialu masowego.\n" << endl;
		return;
	}

	std::string name = substance.get_name();
	int _id1 = check(name);

	if (_id1 == -1)
	{
		cout << "\nSubstancji " << name << " nie ma obecnie w kubku. Dolewam ja do kubka.\n" << endl;
		this->add(substance, 0.001);
		_id1 = check(name);
	}

	size_t count = substances.size();
	if (count == 1)
	{
		cout << "\nW kubku znajduje sie tylko podana substancja, co uniemozliwia nadanie jej procentowego udzialu masowego\n" << endl;
		return;
	}

	if (wanted_mass_coe == 100 && count > 1)
	{
		cout << "\nW kubku znajduje sie wiecej niz jedna substancja, co uniemozliwia nadanie 100% udzialu masowego substancji\n" << endl;
		return;
	}

	if (wanted_mass_coe > 100 || wanted_mass_coe < 0)
	{
		cout << "\nZadany procent udzialu masowego substancji w kubku musi zawierac sie w przedziale 0-100%\n" << endl;
		return;
	}

	if (wanted_mass_coe == 0)
	{
		cout << "\nNie mozna nadac 0% udzialu masowego substancji\n" << endl;
		return;
	}

	double volume_sum = 0;
	double mass_sum = 0;

	for (int i = 0; i < count; i++)
	{
		volume_sum += volumes[i];
		mass_sum += substances[i].get_ro() * volumes[i] * 1000; // Masa w gramach
	}

	double current_mass = substances[_id1].get_ro() * volumes[_id1] * 1000; // Masa substancji w gramach
	double current_mass_coe = (current_mass / mass_sum) * 100;

	const double epsilon = 1e-4; // Tolerancja błędu
	if (abs(current_mass_coe - wanted_mass_coe) < epsilon)
	{
		cout << "\nSubstancja " << name << " ma wymagany procentowy udzial masowy\n" << endl;
		return;
	}

	if (current_mass_coe > wanted_mass_coe && (wanted_mass_coe > 0 && wanted_mass_coe < 100))
	{
		cout << "\nSubstancja " << name << " ma wyzszy procentowy udzial masowy niz zadany\n" << endl;
		return;
	}

	double required_mass = (wanted_mass_coe * mass_sum - 100 * current_mass) / (100 - wanted_mass_coe);
	double required_volume = required_mass / (substances[_id1].get_ro() * 1000); // Obliczenie wymaganej objętości

	cout << "\nW celu osiagniecia " << wanted_mass_coe << "% udzialu masowego substancji " << name
		<< " w kubku, dolewam " << required_volume * 1e6 << " ml tej substancji do kubka" << endl;

	volumes[_id1] += required_volume;
	TCup::show();
}

void TCup::add_mass(std::string name, double wanted_mass_coe)
{
	cout << "\nOperacja: Ustawianie " << wanted_mass_coe << "% udzialu masowego dla substancji: "
		<< name << endl;

	if (substances.empty())
	{
		cout << "\nKubek jest pusty. Dodaj substancje przed proba zmiany jej udzialu masowego.\n" << endl;
		return;
	}

	int _id = get_substance_id(name);
	if (_id == -1)
	{
		cout << "\nSubstancji " << name << " nie mozna dolac, poniewaz nie zostala wczesniej zdefiniowana.\n" << endl;
		return;
	}

	TSubstance substance = substancje[_id];
	int _id1 = check(name);

	if (_id1 == -1)
	{
		cout << "\nSubstancji " << name << " nie ma obecnie w kubku. Dolewam ja do kubka.\n" << endl;
		this->add(substance, 0.001); // Dodanie minimalnej ilości substancji
		_id1 = check(name); // Ponowne sprawdzenie po dodaniu
	}

	size_t count = substances.size();
	if (count == 1)
	{
		cout << "\nW kubku znajduje sie tylko podana substancja, co uniemozliwia nadanie jej procentowego udzialu masowego\n" << endl;
		return;
	}

	if (wanted_mass_coe == 100 && count > 1)
	{
		cout << "\nW kubku znajduje sie wiecej niz jedna substancja, co uniemozliwia nadanie 100% udzialu masowego substancji\n" << endl;
		return;
	}

	if (wanted_mass_coe > 100 || wanted_mass_coe < 0)
	{
		cout << "\nZadany procent udzialu masowego substancji w kubku musi zawierac sie w przedziale 0-100%\n" << endl;
		return;
	}

	if (wanted_mass_coe == 0)
	{
		cout << "\nNie mozna nadac 0% udzialu masowego substancji\n" << endl;
		return;
	}

	double volume_sum = 0;
	double mass_sum = 0;

	for (int i = 0; i < count; i++)
	{
		volume_sum += volumes[i];
		mass_sum += substances[i].get_ro() * volumes[i] * 1000; // Masa w gramach
	}

	double current_mass = substances[_id1].get_ro() * volumes[_id1] * 1000; // Masa substancji w gramach
	double current_mass_coe = (current_mass / mass_sum) * 100;

	const double epsilon = 1e-4; // Tolerancja błędu
	if (abs(current_mass_coe - wanted_mass_coe) < epsilon)
	{
		cout << "\nSubstancja " << name << " ma wymagany procentowy udzial masowy\n" << endl;
		return;
	}

	if (current_mass_coe > wanted_mass_coe && (wanted_mass_coe > 0 && wanted_mass_coe < 100))
	{
		cout << "\nSubstancja " << name << " ma wyzszy procentowy udzial masowy niz zadany\n" << endl;
		return;
	}

	double required_mass = (wanted_mass_coe * mass_sum - 100 * current_mass) / (100 - wanted_mass_coe);
	double required_volume = required_mass / (substances[_id1].get_ro() * 1000); // Obliczenie wymaganej objętości

	cout << "\nW celu osiagniecia " << wanted_mass_coe << "% udzialu masowego substancji " << name
		<< " w kubku, dolewam " << required_volume * 1e6 << " ml tej substancji do kubka" << endl;

	volumes[_id1] += required_volume;
	TCup::show();
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
	if (count == 0)
	{
		cout << "\nKubek jest pusty.\n";
		return;
	}
	double volume_sum = 0;
	double mass_sum = 0;
	for (int i = 0; i < substances.size(); i++)
	{
		volume_sum += volumes[i];
		mass_sum += substances[i].get_ro() * volumes[i] * 1000;
	}
	cout << "\nSubstancje wlane do kubka:" << endl;
	for (int i = 0; i < count; i++)
	{
		double mass = substances[i].get_ro() * volumes[i] * 1000; //grams
		double volume_coe = (volumes[i] / volume_sum) * 100;
		double mass_coe = (mass / mass_sum) * 100;

		cout << i + 1 << ". " << substances[i].get_name() << " -"
			<< " volume: " << volumes[i] * 1e6 << "ml;"
			<< " mass: " << mass << "g;"
			<< " volume coe: " << volume_coe << "%;"
			<< " mass coe: " << mass_coe << "%" << endl;
	}
}

void TCup::merge(TCup& other)
{
	if (other.substances.empty())
	{
		cout << "\nDrugi kubek jest pusty. Nie ma nic do zlania.\n";
		return;
	}
	for (size_t i = 0; i < other.substances.size(); i++)
	{
		const TSubstance& substance = other.substances[i];
		double volume = other.volumes[i];

		int existingIndex = check(substance.get_name());
		if (existingIndex == -1)
		{
			substances.push_back(substance);
			volumes.push_back(volume);

		}
		else
		{
			volumes[existingIndex] += volume;

		}
	}
	other.substances.clear();
	other.volumes.clear();

	cout << "\nZawartosc kubkow zostala zlana.\n";
}
