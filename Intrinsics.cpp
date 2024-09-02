#include <iostream>
#include <stdint.h>
#include <intrin.h>
#include <vector>
#include <array>
#include <fstream>

std::vector<std::array<uint64_t, 3>> _records = std::vector<std::array<uint64_t, 3>>();

void intrinsicsTimings(std::array<uint64_t, 3> *timingArray) {
    int EAX_EBX_ECX_EDX[4] = { 0 };

    timingArray->at(0) = __rdtsc();
    __cpuid(EAX_EBX_ECX_EDX, 0);
    // EAX = Result
    // EBX = "Auth"
    // EDX = "entic"
    // ECX = "AMD"
    // ~ish
    timingArray->at(1) = __rdtsc();
    __nop();
    timingArray->at(2) = __rdtsc();
}

void fixAnyOverflow(std::array<uint64_t, 3> *values) {

    int index = 2;
    while (index > 0)
    {
        if (values->at(index) <= values->at(index - 1)) [[unlikely]]
        {// cpu timestamp counter has overflowed
            uint64_t toMax = (UINT64_MAX) - values->at(index - 1);
            values->at(index) = toMax + values->at(index);
        }
        else [[likely]] {
            values->at(index) = values->at(index) - values->at(index - 1);
        }
        index--;
    }
    // fundamentally altering the meaning of the array to be:
    // [0] = initial value
    // [1] = cpuid time
    // [2] = nop time
}

void intrinsicsPrint() {

    int EAX_EBX_ECX_EDX[4] = {0};
    std::array<uint64_t, 3> vals = {0};

    intrinsicsTimings(&vals);
    fixAnyOverflow(&vals);

    while ((vals.at(2) < 2))
    {
        intrinsicsTimings(&vals);
        fixAnyOverflow(&vals);
    }

    _records.push_back(vals);
    std::cout << "Timings: " << "CPUID: " << vals[1] << " NOP: " << vals[2] << "\n";
}

int main()
{
    std::cout << "intrinsics Timings\n";
    for (size_t i = 0; i < 100; i++)
    {
        intrinsicsPrint();
    }
    std::cout << "Outputting to file:\n";

    // Output to file
    std::ofstream csvfile;
    csvfile.open("local.csv");
    csvfile << "CPUID,NOP\n";

    for (std::array<uint64_t, 3> entry : _records)
    {
        csvfile << entry[1] << "," << entry[2] << "\n";
    }
    csvfile.close();
}