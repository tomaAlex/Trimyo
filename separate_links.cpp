#include <iostream>
#include <fstream>
#include <cstring>

using namespace std;

ifstream in("two_links.txt");
ofstream out1("first_link.txt");
ofstream out2("second_link.txt");

char firstLink[999], secondLink[999];

int main()
{
    in >> firstLink >> secondLink;
    out1 << firstLink;
    out2 << secondLink;
    in.close();
    out1.close();
    out2.close();
    return 0;
}