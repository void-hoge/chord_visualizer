#include <iostream>
#include <vector>

using side = bool;
const side right = true;
const side left = false;

int input(std::vector<int>& v, std::istream& is) {
	int len;
	is >> len;
	std::cout << len << '\n';
	for (int i = 0; i < len; i++) {
		double tmp;
		is >> tmp;
		std::cout << tmp << ' ';
	}
	std::cout << '\n';
	for (int i = 0; i < len; i++) {
		int tmp;
		is >> tmp;
		v.push_back(tmp);
	}
	// for (const auto a: v) std::cerr << a << ' '; std::cerr << '\n';
	return len;
}

int cmpl(const int i, const int n) {
	return n*2+1-i;
}

side left_right(const int i, const int n) {
	// clockwise
	return i < (n+1);
}

int idx(const int i, const int n) {
	return i%n;
}

unsigned diff_of_c(const std::vector<int>& pi, const int i, const int n) { // c_i+1 - c_i
	return (unsigned)(pi.at(idx(i+1,n)) - pi.at(idx(i,n)));
}

bool check(const std::vector<int>& pi) {
	std::vector<int> diff;
	const int n = pi.size();
	for (int i = 0; i < n; i++) {
		int tmp = pi.at(idx(i, n))-pi.at(idx(i+1,n));
		diff.push_back(tmp < 0);
	}
	// for (auto a: diff) std::cerr << a << ' '; std::cerr << '\n';
	int count = 0;
	for (int i = 0; i < n; i++) {
		if (diff.at(i) != diff.at(idx(i+1,n))) {
			count++;
		}
	}
	return count==2;
}

int main() {
	std::vector<int> pi;
	const std::size_t n = input(pi, std::cin);
	std::vector<std::pair<int, int>> result;
	int x, y;
	// i = 1
	x = pi.at(0);
	if (diff_of_c(pi,0,n)%2 == 1) {
		y = pi.at(idx(1,n)); // f
	}else {
		y = cmpl(pi.at(idx(1,n)), n); // g
	}
	result.push_back(std::make_pair(x, y));
	std::cout << x << ", " << y << '\n';
	// i > 1
	for (std::size_t i = 1; i < n; i++) {
		x = cmpl(y, n);
		if (
			((diff_of_c(pi,i,n)%2==1) && (left_right(x, n)==right))
		||
			((diff_of_c(pi,i,n)%2==0) && (left_right(x, n)==left))
		) {
			y = pi.at(idx(i+1,n)); // f
		}else {
			y = cmpl(pi.at(idx(i+1,n)), n); // g
		}
		result.push_back(std::make_pair(x, y));
		std::cout << x << ", " << y << '\n';
	}
	std::cerr << "Conversion completed." << '\n';
	if (check(pi)) {
		std::cerr << "Intersection check: \033[1;4;32mOK\033[0m" << '\n';
	}else {
		std::cerr << "Intersection check: \033[1;4;91mNG\033[0m" << '\n';
	}
	return 0;
}
