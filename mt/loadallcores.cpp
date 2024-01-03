// для загрузки всех ядер и проверки охлаждения
#include <thread>
#include <iostream>
#include <vector>

static bool stop = false;

void work()
{
	while (!stop);
}

int main(int argc, const char * argv[])
{
	auto n = std::thread::hardware_concurrency();
	std::cout << "Threads: " << n << std::endl;
	std::vector<std::thread> pool;
	for (auto i = 0; i < n; ++i) {
		pool.push_back(std::thread(work));
	}
	int c = 0;
	while (c != 'q') {
		std::cout << "Type 'q' to stop:";
		c = getchar();
	}
	stop = true;
	for (auto &&t : pool) {
		if (t.joinable())
			t.join();
	}
}