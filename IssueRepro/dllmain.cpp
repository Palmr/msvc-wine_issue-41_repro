#include "pch.h"

BOOL APIENTRY DllMain(HMODULE hModule,
                      DWORD ul_reason_for_call,
                      LPVOID lpReserved
) {
    char tmp[256], *cp;

    switch (ul_reason_for_call) {
        case DLL_PROCESS_ATTACH:
            GetModuleFileName((HMODULE) hModule, tmp, sizeof(tmp) - 5);
            break;
        case DLL_THREAD_ATTACH:
        case DLL_THREAD_DETACH:
            break;
        case DLL_PROCESS_DETACH:
            break;
        default:
            break;
    }
    return (TRUE);
}

