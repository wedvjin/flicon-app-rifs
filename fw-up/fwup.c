#include <stdio.h>
#include <windows.h>

//todo this shall be modular....

int main(int argc, wchar_t  *argv[])
// int fwup(char *dll_name, wchar_t *  filePath)
{
    printf("Usage: %s dll_name filePath\n",argv[0]); // print greeting
    
    if (argc < 3) // check that there is an argument with the name and path to dll
    {
        printf("[-] Error: name and path to dll not specified, and function name.\n");
        return 1; // exit with error code
    }
    
    // char *dll_name = argv[1]; // take the name and path to dll from the argument
    // char *func_name = argv[2];
    
    char *dll_name = argv[1];
    char *filePathO = argv[2];
    int length = MultiByteToWideChar(CP_UTF8, 0, filePathO, -1, NULL, 0);
    wchar_t *filePath = malloc(length * sizeof(wchar_t));
    MultiByteToWideChar(CP_UTF8, 0, filePathO, -1, filePath, length);

    HMODULE dll_handle = LoadLibrary(dll_name); // try to load dll
     
    if (dll_handle == NULL) // check that dll loaded
    {
        printf("[-] Error: failed to load dll %s.\n", dll_name);
        return 2; // exit with error code
    }
    printf("[+] Success: dll %s loaded at address %p.\n", dll_name, dll_handle); // print success message and address of dll
    // typedef int (*start_func)(); // define the type of function start from dll
    typedef int (*ConnectDfuBootloaderType)(char *);
    ConnectDfuBootloaderType connectDfuBootloader;
    Sleep(1000);
    connectDfuBootloader = (ConnectDfuBootloaderType)GetProcAddress(dll_handle, "connectDfuBootloader"); // get pointer to function start from dll
    if (connectDfuBootloader == NULL) // check that function start exists in dll
    {
        printf("[-] Error: function %s not found in dll %s.\n", "connectDfuBootloader", dll_name);
        FreeLibrary(dll_handle); // free resources occupied by dll
        return 3; // exit with error code
    }
    Sleep(1000);

    int result = connectDfuBootloader("usb1"); // call function start from dll and get its result
    printf("[*] Function connectDfuBootloader return: 0x%x\n",result);
    if (result != 0)
    {
        printf("[-] Error: function %s finished with error.\n","connectDfuBootloader");
        FreeLibrary(dll_handle); // free resources occupied by dll
        return 4; // exit with error code
    }
    Sleep(1000);
    // FreeLibrary(dll_handle); // free resources occupied by dll
    // return 0; // exit with success code

    typedef int (*downloadFileType)(
        const wchar_t *  filePath,  
        unsigned int  address,  
        unsigned int  skipErase,  
        unsigned int  verify,  
        const wchar_t *  binPath  
    );
    
    downloadFileType downloadFile;
    downloadFile = (downloadFileType)GetProcAddress(dll_handle, "downloadFile");
    if (downloadFile == NULL) // check that function start exists in dll
        {
            printf("[-] Error: function %s not found in dll %s.\n", "downloadFile", dll_name);
            FreeLibrary(dll_handle); // free resources occupied by dll
            return 5; // exit with error code
        }
    Sleep(1000);
    int up_result = downloadFile(
        filePath,
        134250496,
        0,
        1,
        filePath
    );
    printf("[*] Function downloadFile return: 0x%x\n",up_result);
    if (up_result != 0) // check that function start returned non-zero value
    {
        printf("[-] Error: function %s finished with error.\n","downloadFile");
        FreeLibrary(dll_handle); // free resources occupied by dll
        return 6; // exit with error code
    }
    Sleep(1000);

    typedef int (*executeType)(
        unsigned int  address
    );
    executeType execute;
    execute = (executeType)GetProcAddress(dll_handle, "execute");
    if (execute == NULL) // check that function start exists in dll
    {
        printf("[-] Error: function %s not found in dll %s.\n", "execute", dll_name);
        FreeLibrary(dll_handle); // free resources occupied by dll
        return 7; // exit with error code
    }
    Sleep(1000);
    int exe_result = execute(
        134250496
    );
    printf("[*] Function execute return: 0x%x\n",exe_result);
    if (exe_result != 0) // check that function start returned non-zero value
        {
            printf("[-] Error: function %s finished with error.\n","downloadFile");
            FreeLibrary(dll_handle); // free resources occupied by dll
            return 8; // exit with error code
        }
    Sleep(1000);
    FreeLibrary(dll_handle); // free resources occupied by dll
    return 0; // exit with success code
}

// typedef int (*ConnectDfuBootloaderType)(char *);


// int callDllFunction(char *dllName, char *functionName, char *param)
// {    
//     char *dll_name = dllName; // take the name and path to dll from the argument
//     char *func_name = functionName;
    
//     HMODULE dll_handle = LoadLibrary(dll_name); // try to load dll
     
//     if (dll_handle == NULL) // check that dll loaded
//     {
//         printf("[-] Error: failed to load dll %s.\n", dll_name);
//         return 2; // exit with error code
//     }
//     printf("[+] Success: dll %s loaded at address %p.\n", dll_name, dll_handle); // print success message and address of dll
 
//     if(func_name == "connectDfuBootloader") {
//         ConnectDfuBootloaderType connectDfuBootloader;
//         connectDfuBootloader func_pointer = (ConnectDfuBootloaderType)GetProcAddress(dll_handle, func_name); // get pointer to function start from dll
//     }
//     start_func start = (start_func)GetProcAddress(dll_handle, func_name); // get pointer to function start from dll
//     if (start == NULL) // check that function start exists in dll
//     {
//         printf("[-] Error: function %s not found in dll %s.\n", func_name, dll_name);
//         FreeLibrary(dll_handle); // free resources occupied by dll
//         return 3; // exit with error code
//     }

//     int port = 9151;
//     int result = start(port); // call function start from dll and get its result
//     printf("[*] Function start return: 0x%x\n",result);
//     if (result == 0) // check that function start returned non-zero value
//     {
//         printf("[-] Error: function %s finished with error.\n",argv[2]);
//         FreeLibrary(dll_handle); // free resources occupied by dll
//         return 4; // exit with error code
//     }
//     printf("[*] Tor on port 9150, press any key to exit...\n"); // print message about Tor launch and waiting for key press
//     getchar(); // wait for key press from user
//     FreeLibrary(dll_handle); // free resources occupied by dll
//     return 0; // exit with success code
// }