#import <mach-o/dyld.h>
#import <dlfcn.h>
#import <substrate.h>
#import <vector>
#import <mach/mach_vm.h>
#import <sys/stat.h>
#import <unistd.h>

static uint64_t slide;
static void *dyld_get_image_name_ptr;
static void *dyld_get_image_vmaddr_slide_ptr;
static void *dyld_get_image_header_ptr;
static void *stat_ptr;
static void *NSGetEnviron_ptr;
static const uint8_t mov_x0_NEGATIVE1[] = { 0x00, 0x00, 0x80, 0x92 };
static const uint8_t mov_x0_2[] = { 0x40, 0x00, 0x80, 0xD2 };
static const uint8_t mov_x0_0[] = { 0x00, 0x00, 0x80, 0xD2 };
static const uint8_t ret[] = { 0xC0, 0x03, 0x5F, 0xD6 };
static const uint8_t jmp_hook_102B04BB8[] = { 0x77, 0xE1, 0x04, 0x94 };
static const uint8_t jmp_hook_102BF9490[] = { 0x41, 0x0F, 0x01, 0x94 };
static const uint8_t jmp_hook_102BFA98C[] = { 0x02, 0x0A, 0x01, 0x94 };
static const uint8_t nop[] = { 0x1F, 0x20, 0x03, 0xD5 };

static uint64_t access_array[] = 
{
    0x1002334BC,
    0x1002334C0,
    0x100233F48,
    0x100233F4C,
};

static uint64_t ptrace_array[] = 
{
    0x100233F10,
    0x100233F14,
    0x102C23A00,
    0x102C23A04,
};

static uint64_t stat_array[] = 
{
    0x102B04BB8,
    0x102BF9490,
    0x102BFA98C,
};

static uint64_t stat1_array[] = 
{
    0x102B04BB4,
    0x102BF948C,
    0x102BFA988,
};

static uint64_t sysctl_array[] = 
{
    0x102AC4120,
    0x102AC4124,
    0x102BFBB7C,
    0x102BFBB80,
    0x102BFBC80,
    0x102BFBC84,
};

static uint64_t symlink_array[] =
{
    0x102BFCE84,
    0x102BFCE88,
};

uint32_t num_bak;
#define BYTESWAP32(num) \
    do { \
        num_bak = num; \
        num = ((num_bak >> 0x18) &0xff); \
        num = num | ((num_bak << 0x8) &0xff0000); \
        num = num | ((num_bak >> 0x8) &0xff00); \
        num = num | ((num_bak << 0x18) &0xff000000); \
    } while(0)

// %group Dyld_get_image_name

// %hookf(const char *, dyld_get_image_name_ptr, int index)
// {
//     const char *orig = %orig;
//     if(strcmp(orig, "TweakInject") == 0) orig = "/A";
//     if(strcmp(orig, "libhooker") == 0) orig = "/A";
//     if(strcmp(orig, "libblackjack") == 0) orig = "/A";
//     if(strcmp(orig, "libsubstrate") == 0) orig = "/A";
//     if(strcmp(orig, "substrate") == 0) orig = "/A";
//     if(strcmp(orig, "Substrate") == 0) orig = "/A";
//     NSLog(@"Fate Bypass: Runtime: dyld_get_image_name: ret: %s index: %d", orig, index);
//     return orig;
// }

// %end

// %group Dyld_get_image_vmaddr_slide

// %hookf(uint64_t, dyld_get_image_vmaddr_slide_ptr, int index)
// {
//     uint64_t orig = %orig;
//     NSLog(@"Fate Bypass: Runtime: dyld_get_image_vmaddr_slide: ret: 0x%llX index: %d new: 0x0", orig, index);
//     orig = 0x0;
//     return orig;
// }

// %end

// %group Dyld_get_image_header

// %hookf(const struct mach_header *, dyld_get_image_header_ptr, int index)
// {
//     const struct mach_header* orig = %orig;
//     Dl_info dylib_info;
//     dladdr(orig, &dylib_info);
//     NSLog(@"Fate Bypass: Runtime: dyld_get_image_header: index: %d dli_fname: %s", index, dylib_info.dli_fname);
//     return orig;
// }

// %end

%group Stat

%hookf(int, stat_ptr, const char *path, struct stat *buf)
{
    NSLog(@"Fate Bypass: Runtime: stat: path: %s", path);
    if(strcmp(path, "/Applications/Cydia.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/Flex.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/GameGemiOS.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/Sileo.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/Zebra.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/iGameGuardian.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/Sileo.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/Zebra.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Applications/iGameGuardian.app") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/BreakThrough") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/Frameworks/CydiaSubstrate.framework") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/LaunchDaemons/com.apple.gg.daemon.plist") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/MobileSubstrate") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/PreferenceLoader/Preferences/LibertyPref.plist") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/PreferenceLoader/Preferences/NoSubstitute.plist") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/Library/dpkg/info/xyz.willy.zebra.list") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/User") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/boot") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/jb") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/lib") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/mnt") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/etc/ssh") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/containers/Bundle/iosbinpack64") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/containers/Bundle/tweaksupport") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/db/stash") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/lib") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/libexec") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/Caches/Snapshots/org.coolstar.SileoStore") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/Caches/com.saurik.Cydia") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/Flex3") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/Preferences/org.coolstar.SileoStore.plist") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/Preferences/xyz.willy.Zebra.plist") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/private/var/mobile/Library/iGameGuardian") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/usr/lib/TweakInject") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/usr/lib/libsubstrate.dylib") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/var/containers/Bundle/iosbinpack64") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/var/containers/Bundle/tweaksupport") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/var/libexec") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else if(strcmp(path, "/var/mobile/Library/Caches/com.saurik.Cydia") == 0) 
    {
        NSLog(@"Fate Bypass: Runtime: stat: /3cf2dc680d10f17a5499e9ebffb08a3e");
        return %orig("/3cf2dc680d10f17a5499e9ebffb08a3e", buf);
    }
    else
    {
        int orig = %orig;
        NSLog(@"Fate Bypass: Runtime: stat: ret: %d path: %s", orig, path);
        return orig;
    }
}

%end

// %group NSGetEnviron

// %hookf(char ***, NSGetEnviron_ptr)
// {
//     char ***orig = %orig;
//     char **env = *orig;
//     NSLog(@"Fate Bypass: Runtime: NSGetEnviron!");
//     while(*env)
//  {
//         NSLog(@"Fate Bypass: Runtime: NSGetEnviron: env: %s", *env);
// 		env++;
// 	}
//     return orig;
// }

// %end

extern "C"
{
    char *path1 = "/3cf2dc680d10f17a5499e9ebffb08a3e";
    int stat_hook(const char *path, struct stat *buf)
    {
        NSLog(@"Fate Bypass: syscall: stat: path: %s", path);
        if(strcmp(path, "/Applications/Cydia.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/Flex.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/GameGemiOS.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/Sileo.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/Zebra.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/iGameGuardian.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/Sileo.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/Zebra.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Applications/iGameGuardian.app") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/BreakThrough") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/Frameworks/CydiaSubstrate.framework") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/LaunchDaemons/com.apple.gg.daemon.plist") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/MobileSubstrate") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/PreferenceLoader/Preferences/LibertyPref.plist") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/PreferenceLoader/Preferences/NoSubstitute.plist") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/Library/dpkg/info/xyz.willy.zebra.list") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/User") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/boot") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/jb") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/lib") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/mnt") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/etc/ssh") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/containers/Bundle/iosbinpack64") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/containers/Bundle/tweaksupport") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/db/stash") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/lib") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/libexec") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/Caches/Snapshots/org.coolstar.SileoStore") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/Caches/com.saurik.Cydia") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/Flex3") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/Preferences/org.coolstar.SileoStore.plist") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/Preferences/xyz.willy.Zebra.plist") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/private/var/mobile/Library/iGameGuardian") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/usr/lib/TweakInject") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/usr/lib/libsubstrate.dylib") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/var/containers/Bundle/iosbinpack64") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/var/containers/Bundle/tweaksupport") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/var/libexec") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else if(strcmp(path, "/var/mobile/Library/Caches/com.saurik.Cydia") == 0)
        {
            NSLog(@"Fate Bypass: syscall: stat: -1");
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile("ADD x0, x0, #0x1");
            __asm__ volatile("MOV x16, #0xBC");
            __asm__ volatile("SVC #0x80");
        }
        else
        {
            __asm__ volatile("ldp x0, x1, [sp], #0x1F0");
            __asm__ volatile(
                "MOV x16, 0xBC"
            );
            __asm__ volatile(
                "SVC #0x80"
            );
        }
    }
}

__attribute__((naked)) int stat_trampoline(const char *path, struct stat *buf)
{
    __asm__ volatile(
        "stp x30, x29, [sp, #-0x10]!"
    );
    __asm__ volatile(
        "stp x0, x1, [sp, #-0x1F0]!"
    );
    __asm__ volatile(
        "bl _stat_hook"
    );
    __asm__ volatile(
        "ldp x30, x29, [sp], #0x10"
    );
    // __asm__ volatile(
    //     "blr x30"
    // );
    // __asm__ volatile(
    //     "blr x16"
    // );
}

#define PATCH(array, patch) \
    do { \
        for(int i = 0; i < sizeof(array) / sizeof(uint64_t); i++) MSHookMemory((void *)(array[i] + slide), (void *)&patch, sizeof(patch)); \
    } while(false)

uint32_t BL_MASK = 0x94;
uint32_t offset;
uint32_t BL_trampoline;

#define BL_PATCH(array, trampoline) \
    do { \
        for(int i = 0; i < sizeof(array) / sizeof(uint64_t); i++) \
        { \
            offset = (uint32_t)((uint64_t)&trampoline - (array[i] + slide)); \
            offset = offset >> 0x2; \
            BYTESWAP32(offset); \
            offset = offset | BL_MASK; \
            BL_trampoline = offset; \
            BYTESWAP32(BL_trampoline); \
            MSHookMemory((void *)(array[i] + slide), (void *)&BL_trampoline, sizeof(BL_trampoline)); \
        } \
    } while(false)

static void init()
{
    NSLog(@"Fate Bypass: initializing...");
    slide = _dyld_get_image_vmaddr_slide(0);
    NSLog(@"Fate Bypass: slide: 0x%llX", slide);
    void *libsystem = dlopen("/usr/lib/libSystem.B.dylib", RTLD_NOW | RTLD_GLOBAL);
    NSLog(@"Fate Bypass: dlerror: %s", dlerror());
    if(libsystem)
    {
        // NSLog(@"Fate Bypass: got libsystem!");
        // dyld_get_image_name_ptr = dlsym(libsystem, "_dyld_get_image_name");
        // NSLog(@"Fate Bypass: dlerror: %s", dlerror());
        // if(dyld_get_image_name_ptr)
        // {
        //     NSLog(@"Fate Bypass: got dyld_get_image_name!");
        //     %init(Dyld_get_image_name);
        // }
        // dyld_get_image_vmaddr_slide_ptr = dlsym(libsystem, "_dyld_get_image_vmaddr_slide");
        // NSLog(@"Fate Bypass: dlerror: %s", dlerror());
        // if(dyld_get_image_name_ptr)
        // {
        //     NSLog(@"Fate Bypass: got dyld_get_image_vmaddr_slide!");
        //     %init(Dyld_get_image_vmaddr_slide);
        // }
        // dyld_get_image_header_ptr = dlsym(libsystem, "_dyld_get_image_header");
        // NSLog(@"Fate Bypass: dlerror: %s", dlerror());
        // if(dyld_get_image_header_ptr)
        // {
        //     NSLog(@"Fate Bypass: got dyld_get_image_header!");
        //     %init(Dyld_get_image_header);
        // }
        stat_ptr = dlsym(libsystem, "stat");
        NSLog(@"Fate Bypass: dlerror: %s", dlerror());
        if(stat_ptr)
        {
            NSLog(@"Fate Bypass: got stat!");
            %init(Stat);
        }
        // NSGetEnviron_ptr = dlsym(libsystem, "_NSGetEnviron");
        // NSLog(@"Fate Bypass: dlerror: %s", dlerror());
        // if(NSGetEnviron_ptr)
        // {
        //     NSLog(@"Fate Bypass: got NSGetEnviron!");
        //     %init(NSGetEnviron);
        // }
    }
    unsetenv("CRANE_CONTAINER_IDENTIFIER");
    unsetenv("SHELL");
	extern char **environ;
	for(int i = 0; environ[i]; i++)
	{
        NSLog(@"Fate Bypass: Init: eniron: %s", environ[i]);
    }
    NSLog(@"Fate Bypass: initializing done!");
}

static void hook()
{
    NSLog(@"Fate Bypass: patching syscalls...");
    // PATCH(ptrace_array, mov_x0_NEGATIVE1);
    // PATCH(stat1_array, nop);
    BL_PATCH(stat_array, stat_trampoline);
    // PATCH(sysctl_array, mov_x0_NEGATIVE1);
    // PATCH(access_array, mov_x0_NEGATIVE1);
    // PATCH(symlink_array, mov_x0_NEGATIVE1);
    NSLog(@"Fate Bypass: patching syscalls done!");
}

%ctor
{
    NSLog(@"Fate Bypass: ctor!");
    init();
    hook();
}
