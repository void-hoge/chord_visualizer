#include <iostream>
#include <vector>

using side = bool;
const side right = true;
const side left = false;

int input(std::vector<int>& v, std::istream& is) {
	int len;
	is >> len;
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

int main() {
	std::vector<int> pi;
	const std::size_t n = input(pi, std::cin);
	std::vector<std::pair<int, int>> result;
	int x, y;
	x = pi.at(0);
	if ((pi.at(idx(1,n))-pi.at(idx(0,n)))%2 == 1) {
		y = pi.at(idx(1,n));
	}else {
		y = cmpl(pi.at(idx(1,n)), n);
	}
	result.push_back(std::make_pair(x, y));
	std::cout << x << ", " << y << '\n';
	for (std::size_t i = 1; i < n; i++) {
		x = cmpl(y, n);
		if (( ((unsigned)(pi.at((idx(i+1,n)))-pi.at((idx(i,n))))%2 == 1) && (left_right(x, n) == right) ) ||
		( ((unsigned)(pi.at((idx(i+1,n)))-pi.at((idx(i,n))))%2 == 0) && (left_right(x, n) == left) ) ) {
			y = pi.at(idx(i+1,n));
		}else {
			y = cmpl(pi.at(idx(i+1,n)), n);
		}
		result.push_back(std::make_pair(x, y));
		std::cout << x << ", " << y << '\n';
	}
	return 0;
}
