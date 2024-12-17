
#include <iostream>
using namespace std;

class Box {
    private:
        int l, b, h;
    public:
        Box() {
            l = 0;
            b = 0;
            h = 0;
        };
        Box(int length, int breadth, int height) {
            l = length;
            b = breadth;
            h = height;
        };
        Box(const Box& BoxToCopy) {
            l = BoxToCopy.l;
            b = BoxToCopy.b;
            h = BoxToCopy.h;
        };
        int getLength() const {
            return l;
        };
        int getBreadth() const {
            return b;
        };
        int getHeight() const {
            return h;
        };
        // Important casting done to prevent integer overflow
        long long CalculateVolume() const {
            return static_cast<long long>(l) * b * h;
        }
};

bool operator<(const Box& BoxA, const Box& BoxB) {
    if (
        BoxA.getLength() < BoxB.getLength()
    ) {
        return true;
    } else if (
        BoxA.getBreadth() < BoxB.getBreadth() && BoxA.getLength() == BoxB.getLength()
    ) {
        return true;
    } else if (
        BoxA.getHeight() < BoxB.getHeight() && BoxA.getBreadth() == BoxB.getBreadth() && BoxA.getLength() == BoxB.getLength()
    ) {
        return true;
    } else {
        return false;
    }
};

ostream& operator<<(ostream& os, const Box& BoxToPrint) {
    os << BoxToPrint.getLength() << ' ' << BoxToPrint.getBreadth() << ' ' << BoxToPrint.getHeight();
    return os;
};


void check2()
{
	int n;
	cin>>n;
	Box temp;
	for(int i=0;i<n;i++)
	{
		int type;
		cin>>type;
		if(type ==1)
		{
			cout<<temp<<endl;
		}
		if(type == 2)
		{
			int l,b,h;
			cin>>l>>b>>h;
			Box NewBox(l,b,h);
			temp=NewBox;
			cout<<temp<<endl;
		}
		if(type==3)
		{
			int l,b,h;
			cin>>l>>b>>h;
			Box NewBox(l,b,h);
			if(NewBox<temp)
			{
				cout<<"Lesser\n";
			}
			else
			{
				cout<<"Greater\n";
			}
		}
		if(type==4)
		{
			cout<<temp.CalculateVolume()<<endl;
		}
		if(type==5)
		{
			Box NewBox(temp);
			cout<<NewBox<<endl;
		}

	}
}

int main()
{
	check2();
}